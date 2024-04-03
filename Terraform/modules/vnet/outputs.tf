output "vnet_1_name" {
  value       = azurerm_virtual_network.vnet1.name
  description = "Network name"
}

output "vnet_1_id" {
  value       = azurerm_virtual_network.vnet1.id
  description = "The ID of the virtual network"
}

output "subnet_1_ids" {
  value       = { for s in azurerm_subnet.subnet1 : s.name => s.id }
  description = "The map of subnet IDs"
}
