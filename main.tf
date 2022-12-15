terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }

    #    aws = {
    #      source = "hashicorp/aws"
    #      version = "= 3.0"
    #    }
    #
    #    kubernetes = {
    #      source = "hashicorp/kubernetes"
    #      version = ">= 2.0.0"
    #    }
  }

}

provider "azurerm" {
  features {
    #    resource_group {
    #      prevent_deletion_if_contains_resources = true
    #      }
    #
    #    virtual_machine {
    #      delete_os_disk_on_deletion = true
    #      graceful_shutdown = false
    #      skip_shutdown_and_force_delete = false
    #    }
    #
    #    key_vault {
    #      purge_soft_delete_on_destroy = true
    #      recover_soft_deleted_key_vaults = true
    #    }
  }
  # subscription_id = "b42d41fc-457e-4d69-bf5f-d6ca999ef2a0"
  # client_id       = "79baa2b9-8087-4140-8329-76e89d92b8dc"
  # client_secret   = var.client_secret
  # tenant_id       = "aa141e2a-a555-4d1b-a870-173addaf2cb3"
}

locals {
  assetname = "ediwn"
  location  = "eastasia"
}

resource "azurerm_resource_group" "testgroup" {
  name     = "${var.prefix}-testgroup"
  location = var.location
  tags = {
    Env  = "DevGroup"
    Name = "testrg01"
  }
}

module "network" {
  source = "./modules/network"

  prefix = var.prefix
  location = azurerm_resource_group.testgroup.location
  resource_group_name = azurerm_resource_group.testgroup.name
  environment = var.environment
}

module "storageaccount" {
  source                  = "./modules/storageaccount"
  resource_group_name     = azurerm_resource_group.testgroup.name
  resource_group_location = azurerm_resource_group.testgroup.location
  assetname               = local.assetname
  environment             = var.environment
  instance_count          = 2
}

module "storageaccout" {
  source                  = "./modules/storageaccount"
  resource_group_name     = azurerm_resource_group.testgroup.name
  resource_group_location = azurerm_resource_group.testgroup.location
  assetname               = "test2"
  environment             = var.environment
  instance_count          = 2  
}