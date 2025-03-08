output "network_interface_ids" {
  description = "IDs of the provisioned network interfaces."
  value       = { for k, v in azurerm_network_interface.modular_nic : k => v.id }
}

output "virtual_machine_ids" {
  description = "IDs of the provisioned virtual machines."
  value       = { for k, v in azurerm_linux_virtual_machine.modular_vm : k => v.id }
}
