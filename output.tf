output "vm_id" {
  value       = azurerm_virtual_machine.vm.id
  description = "The ID of the virtual machine."
}

output "public_ip_address" {
  value       = var.public_ip_enabled ? azurerm_public_ip.vm_public_ip[0].ip_address : null
  description = "The public IP address of the VM, if enabled."
}

output "private_ip_address" {
  value       = azurerm_network_interface.vm_nic.ip_configuration[0].private_ip_address
  description = "The private IP address of the VM."
}

output "vm_name" {
  value       = azurerm_virtual_machine.vm.name
  description = "The name of the virtual machine."
}
