resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = ["10.10.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = ["10.10.2.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault"]
}