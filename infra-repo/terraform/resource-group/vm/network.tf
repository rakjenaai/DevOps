# Create the Virtual Network for the Docker VM
resource "azurerm_virtual_network" "main" {

  # Name of the Virtual Network
  name = "docker-vm-01-vnet"

  # Azure region where the VNet will be created
  location = "eastus"

  # Resource group where the VNet will live
  resource_group_name = "rg-dev-platform"

  # Address range available inside the VNet
  address_space = [
    "10.20.0.0/16"
  ]

  # Tags used to identify and manage the resource
  tags = {
    # Environment classification
    Environment = "dev"

    # Identifies Terraform as the manager
    ManagedBy = "Terraform"

    # Identifies this practice project
    Project = "docker-compose-lab"
  }
}


# Create a subnet inside the Virtual Network
resource "azurerm_subnet" "main" {

  # Name of the subnet
  name = "docker-vm-01-subnet"

  # Resource group containing the VNet
  resource_group_name = "rg-dev-platform"

  # Attach this subnet to the VNet created above
  virtual_network_name = azurerm_virtual_network.main.name

  # IP address range available to resources in this subnet
  address_prefixes = [
    "10.20.1.0/24"
  ]
}