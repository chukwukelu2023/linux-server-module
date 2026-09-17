resource "azapi_resource" "ssh_public_key" {
  count     = var.admin-password == null || var.public-ssh-key == null ? 1 : 0
  type      = var.ssh-key-type
  name      = "${local.name}-ssh-key"
  location  = var.vm-location
  parent_id = var.parent-resource-group-id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  count       = var.admin-password == null || var.public-ssh-key == null ? 1 : 0
  type        = var.ssh-key-type
  resource_id = azapi_resource.ssh_public_key[0].id
  action      = var.ssh-key-action
  method      = var.ssh-key-method
  body = jsonencode({
    encryptionType = var.ssh-key-encryption-type
  })
  response_export_values = var.ssh-key-response-export-values
}
