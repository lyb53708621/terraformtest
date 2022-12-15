terraform {
  backend "azurerm" {
    resource_group_name  = "terraform_test"
    storage_account_name = "tfstatefileyibo"
    container_name       = "tfstatefilecontainer"
    key                  = "dev.terrasform.tfstate"
  }
}