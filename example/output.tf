output "vm-private-ip" {
  value = module.virtual_machine["acuop"].private_ip_address
}

output "vm-public-ip" {
  value = module.virtual_machine["acuop"].public_ip_address
}

output "vm-admin-username" {
  value = module.virtual_machine["acuop"].admin_username
}

output "vm-ssh-private-key" {
  value     = module.virtual_machine["acuop"].ssh_private_key
  sensitive = true
}