output "aks_subnet_id" {
  description = "Resource ID of the subnet reserved for AKS nodes."
  value       = azurerm_subnet.aks.id
}

output "app_subnet_id" {
  description = "Resource ID of the subnet reserved for application compute."
  value       = azurerm_subnet.app.id
}