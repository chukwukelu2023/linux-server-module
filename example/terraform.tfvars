vm-specification = {
  "acuop" = {
    vm-location                      = "westeurope"
    environment                      = "develop"
    project                          = "lv"
    resource-group-name              = "lv-rg"
    admin-username                   = null
    vm-size                          = "Standard_B1s"
    os-disk-caching                  = "ReadWrite"
    os-disk-storage-account-type     = "Standard_LRS"
    os-disk-size-gb                  = 30
    source-image-reference-publisher = "Canonical"
    source-image-reference-offer     = "0001-com-ubuntu-server-jammy"
    source-image-reference-sku       = "22_04-lts"
    source-image-reference-version   = "latest"
    computer-name                    = "lv-vm"
    tags = {
      "Environment" = "dev"
      "Project"     = "lv"
      "Deployment"  = "Terraform"
      "Location"    = "West Europe"
    }
  }
}

resource-group-name   = "lv-rg-1"
vnet-name             = "lv-vnet-1"
vm-location           = "westeurope"
vnet-address-space    = ["10.2.0.0/16"]
subnet-name           = "lv-subnet-1"
subnet-address-prefix = ["10.2.0.0/24"]
storage-account-name                = "tehcoopstaging"
storage-account-rg-name             = "rg-prod-test"
# storage-account-name                = "louisvilleadmin"
# storage-account-rg-name             = "general-rg"
nsg-rule-name                       = "ssh"
nsg-rule-priority                   = 100
nsg-rule-direction                  = "Inbound"
nsg-rule-access                     = "Allow"
nsg-rule-protocol                   = "Tcp"
nsg-rule-source-port-range          = "*"
nsg-rule-destination-port-range     = "22"
nsg-rule-source-address-prefix      = "*"
nsg-rule-destination-address-prefix = "*"
