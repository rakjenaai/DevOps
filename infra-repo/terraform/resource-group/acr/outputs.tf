output "id" {
  description = "Resource ID of the container registry."
  value       = azurerm_container_registry.main.id
}

output "name" {
  description = "Name of the container registry."
  value       = azurerm_container_registry.main.name
}

output "login_server" {
  description = "Registry login server hostname."
  value       = azurerm_container_registry.main.login_server
}