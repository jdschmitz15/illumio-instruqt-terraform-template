output "azure_jump_ip" {
  value       = azurerm_public_ip.JumpIP
  description = "The public IP address of azure jump server."
}