terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-prod-test"
    storage_account_name = "tehcoopstaging"
    container_name       = "tfstate"
    key                  = "linux-server-module.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # subscription_id = var.subscription-id
  features {
  }
}