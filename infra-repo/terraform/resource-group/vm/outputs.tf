output "id" {
  description = "Resource ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.main.id
}

output "name" {
  description = "Name of the virtual machine."
  value       = azurerm_linux_virtual_machine.main.name
}

output "private_ip_address" {
  description = "Private IP assigned to the VM network interface."
  value       = azurerm_network_interface.main.private_ip_address
}

output "identity_principal_id" {
  description = "Principal ID of the VM system-assigned managed identity."
  value       = azurerm_linux_virtual_machine.main.identity[0].principal_id
}