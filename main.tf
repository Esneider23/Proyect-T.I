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

resource "azurerm_resource_group" "database" {
  name     = "database"
  location = "eastus"
}