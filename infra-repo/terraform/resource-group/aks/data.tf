data "azurerm_resource_group" "existing" {
  name = "rg-dev-platform"
}

data "azurerm_client_config" "current" {}

data "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  virtual_network_name = "vnet-dev-platform"
  resource_group_name  = data.azurerm_resource_group.existing.name
}

data "azurerm_container_registry" "existing" {
  name                = "acrdevplatform001"
  resource_group_name = data.azurerm_resource_group.existing.name
}