
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-dev-platform"
    storage_account_name = "rkjstorage"
    container_name       = "tfstate"
    key                  = "resource-group.tfstate"
    use_azuread_auth     = true
  }

}

#
#Rakesh
