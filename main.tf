locals {
  name = "${var.project}-${var.environment}"
}

resource "azurerm_network_interface" "this" {
  name                = "${local.name}-nic"
  location            = var.vm-location
  resource_group_name = var.resource-group-name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                            = "${local.name}-vm"
  resource_group_name             = var.resource-group-name
  location                        = var.vm-location
  size                            = var.vm-size
  admin_username                  = var.admin-username == null ? "${local.name}-vm" : var.admin-username
  network_interface_ids           = length(var.network-interface-ids) > 0 ? var.network-interface-ids : [azurerm_network_interface.this.id]
  computer_name                   = var.computer-name != null ? var.computer-name : "${local.name}"
  disable_password_authentication = var.public-ssh-key != null || var.admin-password == null ? true : false
  admin_password                  = var.public-ssh-key == null ? var.admin_password : null
  custom_data                     = var.custom-data
  user_data                       = var.user-data

  admin_ssh_key {
    username   = var.admin-username == null ? "${local.name}-vm" : var.admin-username
    public_key = var.public-ssh-key != null ? var.public-ssh-key : jsondecode(azapi_resource_action.ssh_public_key_gen[0].output).publicKey
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
    name                 = var.os-disk_name
  }

  boot_diagnostics {
    storage_account_uri = var.bootdiagnostic-storage-account-uri
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  tags = var.tags
}