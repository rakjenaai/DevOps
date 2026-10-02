terraform {
  # Minimum Terraform version required
  required_version = ">= 1.5.0"

  # Define the providers used by this configuration
  required_providers {
    azurerm = {
      # Azure Resource Manager provider
      source = "hashicorp/azurerm"

      # Use AzureRM 4.x versions
      version = "~> 4.0"
    }
  }

  # Store Terraform state remotely in Azure Storage
  backend "azurerm" {
    # Resource group containing the storage account
    resource_group_name = "rg-dev-platform"

    # Azure Storage Account containing Terraform state
    storage_account_name = "rkjstorage"

    # Blob container containing the state file
    container_name = "tfstate"

    # State file for this VM component
    key = "vm.tfstate"

    # Authenticate to the backend using Microsoft Entra ID
    use_azuread_auth = true
  }
}