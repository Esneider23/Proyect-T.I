terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Backup-terraform"
    storage_account_name = "backupstate"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

variable "password" {}

provider "azurerm" {
  features {
  }
}

variable "imagebuild" {
  type = string
  description = "the latest image build version"
}

resource "azurerm_resource_group" "database" {
  name     = "database"
  location = "eastus"
}

resource "azurerm_cosmosdb_postgresql_cluster" "database" {
  name                            = "database-proyect"
  resource_group_name             = azurerm_resource_group.database.name
  location                        = azurerm_resource_group.database.location
  administrator_login_password    = "${var.password}"
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 0
}
output "cosmosdb_connectionstrings" {
   value = "host=c-${azurerm_cosmosdb_postgresql_cluster.database.name}.postgres.cosmos.azure.com port=5432;dbname=citus;user=citus;password=${azurerm_cosmosdb_postgresql_cluster.database.administrator_login_password};sslmode=require"
   sensitive   = true
}

