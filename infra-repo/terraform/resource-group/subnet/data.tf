data "azurerm_resource_group" "existing" {
  name = "rg-dev-platform"
}

data "azurerm_virtual_network" "existing" {
  name                = "vnet-dev-platform"
  resource_group_name = data.azurerm_resource_group.existing.name
}