terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "Backup-terraform"
    storage_account_name = "terraformstateti"
    container_name       = "state"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rg_utbapp" {
  name = "rg_utbapp" # this is the name on azure
  location = "eastus" # data center location on azure
}