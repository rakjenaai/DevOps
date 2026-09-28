output "resource_group_name" {
  description = "Name of the shared platform resource group."
  value       = data.azurerm_resource_group.existing.name
}

output "resource_group_location" {
  description = "Azure region of the shared platform resource group."
  value       = data.azurerm_resource_group.existing.location
}

output "virtual_network_id" {
  description = "Resource ID of the platform virtual network."
  value       = azurerm_virtual_network.main.id
}

output "virtual_network_name" {
  description = "Name of the platform virtual network."
  value       = azurerm_virtual_network.main.name
}