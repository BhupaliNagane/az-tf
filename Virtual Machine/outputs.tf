output "resource_group_id" {
  description = "The ID of the existing resource group"
  value       = data.azurerm_resource_group.existingResourceGroup.id
}

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.azVNet.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.azSubnet.id
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.azNIC.id
}

output "virtual_machine_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.azVM.name
}

output "virtual_machine_public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_network_interface.azNIC.ip_configuration[0].public_ip_address_id
}