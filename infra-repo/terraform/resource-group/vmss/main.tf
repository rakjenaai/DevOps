variable "ssh_public_key" {
  description = "OpenSSH public key matching the private key used to access the scale set instances."
  type        = string
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                            = "dev-platform-vmss"
  location                        = data.azurerm_resource_group.existing.location
  resource_group_name             = data.azurerm_resource_group.existing.name
  sku                             = "Standard_B2s"
  instances                       = 1
  admin_username                  = "azureuser"
  disable_password_authentication = true
  upgrade_mode                    = "Manual"
  overprovision                   = false

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  network_interface {
    name    = "primary"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = data.azurerm_subnet.app.id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "dev-platform"
  }
}