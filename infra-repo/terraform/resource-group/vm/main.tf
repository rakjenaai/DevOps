locals {
  vm_name = "dev-platform-vm01"
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "dev-platform"
  }
}

variable "ssh_public_key" {
  description = "OpenSSH public key matching the private key used to access the VM."
  type        = string
}

resource "azurerm_network_interface" "main" {
  name                = "${local.vm_name}-nic"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.tags
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = local.vm_name
  computer_name                   = local.vm_name
  location                        = data.azurerm_resource_group.existing.location
  resource_group_name             = data.azurerm_resource_group.existing.name
  size                            = "Standard_B2s"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.main.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${local.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}