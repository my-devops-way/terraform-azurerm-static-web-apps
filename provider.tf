terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate12528"
    container_name       = "tfstate"
    key                  = "test"
  }
}
provider "azurerm" {
  features {}
}
