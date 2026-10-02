resource "azurerm_resource_group" "main" {
  name     = "rg-dev-platform"
  location = "eastus"

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "dev-platform"
  }
}
#
