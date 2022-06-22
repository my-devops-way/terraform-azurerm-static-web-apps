terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.9.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "xxxxx"
    storage_account_name = "xxxxx"
    container_name       = "xxxxx"
    key                  = "xxxxx"
  }
}
provider "azurerm" {
  features {}
}
