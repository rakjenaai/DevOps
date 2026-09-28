data "azurerm_resource_group" "existing" {
  name = "rg-dev-platform"
}

data "azurerm_subnet" "app" {
  name                 = "snet-app"
  virtual_network_name = "vnet-dev-platform"
  resource_group_name  = data.azurerm_resource_group.existing.name
}