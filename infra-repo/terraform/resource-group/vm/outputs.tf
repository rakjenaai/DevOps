# Display the VM name after Terraform completes
output "vm_name" {

  # Get the VM name from the VM resource
  value = azurerm_linux_virtual_machine.main.name
}


# Display the public IP address
output "public_ip_address" {

  # Get the IP address from the Public IP resource
  value = azurerm_public_ip.main.ip_address
}


# Display an SSH command for connecting to the VM
output "ssh_command" {

  # Build the SSH command using the generated public IP
  value = "ssh azureuser@${azurerm_public_ip.main.ip_address}"
}