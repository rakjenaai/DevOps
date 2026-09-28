locals {
  resource_group_name  = "rg-dev-platform"
  virtual_network_name = "vnet-dev-platform"
  address_space        = ["10.10.0.0/16"]
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "dev-platform"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = local.virtual_network_name
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = local.address_space
  tags                = local.tags
}