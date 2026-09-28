output "id" {
  description = "Resource ID of the VM scale set."
  value       = azurerm_linux_virtual_machine_scale_set.main.id
}

output "name" {
  description = "Name of the VM scale set."
  value       = azurerm_linux_virtual_machine_scale_set.main.name
}

output "instances" {
  description = "Configured number of VM scale set instances."
  value       = azurerm_linux_virtual_machine_scale_set.main.instances
}

output "identity_principal_id" {
  description = "Principal ID of the VM scale set system-assigned managed identity."
  value       = azurerm_linux_virtual_machine_scale_set.main.identity[0].principal_id
}