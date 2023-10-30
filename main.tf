terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.78.0"
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
  features {}
}

variable "imagebuild" {
  type = string
  description = "the latest image build version"
}

resource "azurerm_resource_group" "rg_utbapp" {
  name = "rg_utbapp" # this is the name on azure
  location = "eastus" # data center location on azure
}

resource "azurerm_resource_group" "database" {
  name = "database" 
  location = "eastus" 
}

resource "azurem_cosmosdb_postgresql_cluster" "database"{
    name = "database-cluster"
    resource_group_name             = azurerm_resource_group.database.name
    location                        = azurerm_resource_group.database.location
    administrator_login_password    = "H@Sh1CoR3!"
    coordinator_storage_quota_in_mb = 131072
    coordinator_vcore_count         = 2
    node_count                      = 0
}