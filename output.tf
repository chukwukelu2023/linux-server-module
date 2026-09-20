output "public_ip_address" {
  value       = azurerm_linux_virtual_machine.this.public_ip_address
  description = "The Public IP Address of the Virtual Machine. This will be null if no Public IP Address is associated with the Primary Network Interface."
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.this.private_ip_address
  description = "The Private IP Address of the Virtual Machine. This will be null if no Private IP Address is associated with the Primary Network Interface."
}

output "admin_username" {
  value       = azurerm_linux_virtual_machine.this.admin_username
  description = "The Admin Username of the Virtual Machine."
}

output "ssh_private_key" {
  value       = var.admin-password == null && var.public-ssh-key == null ? jsondecode(azapi_resource_action.ssh_public_key_gen[0].output).privateKey : null
  description = "The Private Key of the SSH Public Key resource. This will be null if the Admin Password is provided or a Public SSH Key is provided."
  sensitive   = true
}


output "linux_vm" {
  value       = azurerm_linux_virtual_machine.this
  description = "Azure linux vm that will be created"
  sensitive   = true
}
