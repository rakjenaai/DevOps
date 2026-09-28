data "azurerm_resource_group" "existing" {
  name = "rg-dev-platform"
}

data "azurerm_client_config" "current" {}