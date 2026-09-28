resource "azurerm_container_registry" "main" {
  name                          = "acrdevplatform001"
  resource_group_name           = data.azurerm_resource_group.existing.name
  location                      = data.azurerm_resource_group.existing.location
  sku                           = "Basic"
  admin_enabled                 = false
  public_network_access_enabled = true

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "dev-platform"
  }
}