variable "vm-location" {
  type        = string
  description = "(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "environment" {
  type        = string
  description = "(Required) The environment for the Linux Virtual Machine. Changing this forces a new resource to be created."
}

variable "project" {
  type        = string
  description = "(Required) The project for creating the Linux Virtual machine."
}

variable "vm-name" {
  type        = string
  description = "(Optional) The name of the Linux Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "network-interface-ids" {
  type        = list(string)
  description = "(Optional) A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine. When this list is empty, a new Network Interface will be created and attached to the Virtual Machine. Changing this forces a new resource to be created."
  default     = []
}

variable "resource-group-name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Linux Virtual Machine. Changing this forces a new resource to be created."
}

variable "vm-size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_D4_v5."
}

variable "admin-username" {
  type        = string
  description = "(Optional) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "admin-password" {
  type        = string
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "public-ssh-key" {
  type        = string
  description = "(Optional) The Public Key which should be used for authentication, which needs to be in ssh-rsa format with at least 2048-bit or in ssh-ed25519 format. Changing this forces a new resource to be created."
  default     = null
}

variable "computer-name" {
  type        = string
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created."
  default     = null
}

variable "custom-data" {
  type        = string
  description = "(Optional) The custom data to be passed to the Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "user-data" {
  type        = string
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."
  default     = null
}

variable "bootdiagnostic-storage-account-uri" {
  type        = string
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "os_disk_caching" {
  type        = string
  description = "(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "(Required) The Type of Storage Account which should be used for the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, Standard_ZRS and Premium_ZRS."
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  default     = null
}

variable "os-disk_name" {
  type        = string
  description = "(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
  default     = null
}


variable "source_image_reference_publisher" {
  type        = string
  description = "(Required) The Publisher of the Image which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "source_image_reference_offer" {
  type        = string
  description = "(Required) The Offer of the Image which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "source_image_reference_sku" {
  type        = string
  description = "(Required) The SKU of the Image which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "source_image_reference_version" {
  type        = string
  description = "(Required) The Version of the Image which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "admin_password" {
  type        = string
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the Subnet which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "private_ip_allocation" {
  type        = string
  description = "(Optional) The Private IP Address Allocation Method which should be used for the Primary Network Interface on this Virtual Machine. Possible values are Dynamic and Static. Changing this forces a new resource to be created."
  default     = "Dynamic"
}

variable "ip_configuration_name" {
  type        = string
  description = "(Optional) The Name which should be used for the Primary Network Interface IP Configuration on this Virtual Machine. Changing this forces a new resource to be created."
  default     = "internal"
}

variable "public_ip_address_id" {
  type        = string
  description = "(Optional) The ID of the Public IP Address which should be used for the Primary Network Interface on this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "parent-resource-group-id" {
  type        = string
  description = "(Optional) The ID of the Resource Group which should be used for creating the SSH Public Key resource. Changing this forces a new resource to be created."
  default     = null
}

variable "ssh-key-action" {
  type        = string
  description = "(Optional) The action to be performed on the SSH Public Key resource. Possible values are generateKeyPair and getPublicKey. Changing this forces a new resource to be created."
  default     = "generateKeyPair"
}

variable "ssh-key-response-export-values" {
  type        = list(string)
  description = "(Optional) The values to be exported from the SSH Public Key resource action response. Possible values are publicKey and privateKey. Changing this forces a new resource to be created."
  default     = ["publicKey", "privateKey"]
}

variable "ssh-key-type" {
  type        = string
  description = "(Optional) The type of the SSH Public Key resource. Possible values are Microsoft.Compute/sshPublicKeys@2022-11-01. Changing this forces a new resource to be created."
  default     = "Microsoft.Compute/sshPublicKeys@2022-11-01"
}

variable "ssh-key-method" {
  type        = string
  description = "(Optional) The HTTP method to be used for the SSH Public Key resource action. Possible values are GET, POST, PUT, DELETE, PATCH. Changing this forces a new resource to be created."
  default     = "POST"
}

variable "ssh-key-encryption-type" {
  type        = string
  description = "(Optional) The encryption type to be used for the SSH Public Key resource action. Possible values are RSA and ED25519. Changing this forces a new resource to be created."
  default     = "RSA"
}

variable "user_data" {
  type        = string
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."
  default     = null
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "custom_data" {
  type        = string
  description = "(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "identity_type" {
  type        = string
  description = "(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) A list of User Assigned Managed Identity IDs which should be assigned to this Linux Virtual Machine. Changing this forces a new resource to be created."
  default     = []
}