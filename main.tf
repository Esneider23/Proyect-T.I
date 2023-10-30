terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Backup-terraform"
    storage_account_name = "newback"
    container_name       = "new"
    key                  = "terraform.tfstate"
  }
}

variable "password" {}

provider "azurerm" {
  features {
  }
}
