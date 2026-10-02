# Create the Network Interface Card for the VM
resource "azurerm_network_interface" "main" {

  # NIC name
  name = "docker-vm-01-nic"

  # Azure region
  location = "eastus"

  # Resource group containing the NIC
  resource_group_name = "rg-dev-platform"


  # Configure the NIC IP settings
  ip_configuration {

    # Name of the IP configuration
    name = "internal"

    # Attach NIC to our subnet
    subnet_id = azurerm_subnet.main.id

    # Let Azure automatically assign a private IP
    private_ip_address_allocation = "Dynamic"

    # Attach the public IP created earlier
    public_ip_address_id = azurerm_public_ip.main.id
  }


  # Tags for the NIC
  tags = {
    # Environment classification
    Environment = "dev"

    # Terraform manages the resource
    ManagedBy = "Terraform"

    # Project identification
    Project = "docker-compose-lab"
  }
}


# Associate the NSG with the NIC
resource "azurerm_network_interface_security_group_association" "main" {

  # NIC that will receive the security rules
  network_interface_id = azurerm_network_interface.main.id

  # NSG containing SSH and HTTP rules
  network_security_group_id = azurerm_network_security_group.main.id
}


# Create the Ubuntu Linux VM
resource "azurerm_linux_virtual_machine" "main" {

  # VM name
  name = "docker-vm-01"

  # Resource group containing the VM
  resource_group_name = "rg-dev-platform"

  # Azure region
  location = "eastus"

  # VM size / compute capacity
  size = "Standard_B2s"

  # Linux administrator username
  admin_username = "azureuser"

  # NIC attached to the VM
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  # Disable password-based SSH login
  disable_password_authentication = true


  # Configure SSH public-key authentication
  admin_ssh_key {

    # Linux username associated with the key
    username = "azureuser"

    # Your SSH public key
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPKusJpJ3oC8qLBpeLtqtZOMcrJ4K6t1VN3vRQqVa/L terraform-vmss"
  }

  
  # Configure the VM operating-system disk
  os_disk {

    # Enable read/write caching
    caching = "ReadWrite"

    # Use standard locally redundant storage
    storage_account_type = "Standard_LRS"
  }


  # Select the Ubuntu image
  source_image_reference {

    # Image publisher
    publisher = "Canonical"

    # Ubuntu 24.04 offer
    offer = "ubuntu-24_04-lts"

    # Server SKU
    sku = "server"

    # Use the latest available version
    version = "latest"
  }


  # Run cloud-init when the VM is first created
  custom_data = base64encode(
    file("${path.module}/cloud-init.yaml")
  )


  # Resource tags
  tags = {

    # Environment classification
    Environment = "dev"

    # Terraform manages the VM
    ManagedBy = "Terraform"

    # Project identification
    Project = "docker-compose-lab"
  }
}