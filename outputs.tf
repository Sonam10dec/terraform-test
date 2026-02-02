output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.example.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.example.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.example.name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.example.id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.example.name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.example.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.example.name
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.example.private_ip_address
}
