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
  subscription_id = "b3a844cf-108f-48bb-a2ce-33911078b034"
  tenant_id       = "88cf8521-ceb7-4d6a-a22f-d87438337dd3"
  client_secret   = "-l48Q~PbjVfLJMeL8ONQJPAVfBuFQFQG1QedtadR"
  client_id       = "c46dc770-b2e8-48d8-ae2a-96cac7b216ea"
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