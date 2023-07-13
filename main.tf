terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
}
locals {
    # get json 
    json_data = "/frontend/staticwebapp.config.json"
}
resource "azurerm_resource_group" "sita-sig-swa-pacfilehost" {
  name     = var.resgroupname
  location = var.location
  
}
resource "azurerm_static_site" "sita-sig-staticsite-pacfilehost" {
  name                = var.name
  resource_group_name = azurerm_resource_group.sita-sig-swa-pacfilehost.name
  location            = var.location
}

resource azapi_resource_action appsetting {
  type = "Microsoft.Web/staticSites/config@2022-03-01"
  resource_id = "${azurerm_static_site.sita-sig-staticsite-pacfilehost.id}/config/appsettings"
  method = "PUT"

  body = local.json_data
    }
  




# ######################################################################################################################
# before creating azurerm_static_site_custom_domain resource you have to create a cname record in your domain provider.
# example: 
# type  name          value
# cname my.domain.com azurerm_static_site.example.default_host_name (value)
# ######################################################################################################################

/**
  resource "azurerm_static_site_custom_domain" "example" {
  domain_name     = var.domain
  static_site_id  = azurerm_static_site.example.id
  validation_type = "cname-delegation"
}
*/