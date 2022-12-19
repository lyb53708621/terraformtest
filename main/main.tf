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
}

resource "azurerm_resource_group" "testgroup" {
  name     = "${var.prefix}-testgroup"
  location = var.location
  tags = {
    Env  = "DevGroup"
    Name = "testrg0101"
  }
}

module "test-nsg" {
  source = "./modules/nsg"

  resource_group_name   = azurerm_resource_group.testgroup.name
  location              = azurerm_resource_group.testgroup.location
  network_security_group_name   = "terraform-test-nsg"
  source_address_prefix = ["10.0.3.0/24"]
  predefined_rules = [
    {
      name     = "SSH"
      priority = "500"
      direction              = "Inbound"
      access                 = "Allow"
    },
    {
      name              = "LDAP"
      source_port_range = "1024-1026"
      direction              = "Inbound"
      access                 = "Allow"
    }
  ]

  custom_rules = [
    {
      name                   = "myssh"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "10.151.0.0/24"
      description            = "description-myssh"
    },
    {
      name                    = "myhttp"
      priority                = 200
      direction               = "Inbound"
      access                  = "Allow"
      protocol                = "Tcp"
      source_port_range       = "*"
      destination_port_range  = "8080"
      source_address_prefixes = ["10.151.0.0/24", "10.151.1.0/24"]
      description             = "description-http"
    },
  ]

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.testgroup]
}

module "terraform-test-vnet" {
  source = "./modules/vnet"

  location            = azurerm_resource_group.testgroup.location
  resource_group_name = azurerm_resource_group.testgroup.name
  vnet_name           = var.terraform_test_vnet_name
  address_space       = var.terraform_test_vnet_address_space
  subnet_names        = var.terraform_test_vnet_subnet_names
  subnet_prefixes     = var.terraform_test_vnet_subnet_prefixes
  use_for_each        = false
  environment         = var.environment
  network_security_group_id = module.test-nsg.network_security_group_id

}

module "edwin_sto" {
  source                  = "./modules/storageaccount"
  resource_group_name     = azurerm_resource_group.testgroup.name
  resource_group_location = azurerm_resource_group.testgroup.location
  assetname               = "edwin"
  environment             = var.environment
  instance_count          = 2
}

module "test2_sto" {
  source                  = "./modules/storageaccount"
  resource_group_name     = azurerm_resource_group.testgroup.name
  resource_group_location = azurerm_resource_group.testgroup.location
  assetname               = "test2"
  environment             = var.environment
  instance_count          = 2
}