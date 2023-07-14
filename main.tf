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
    json_data = "${file("staticwebapp.config.json")}"
    pacfile = "${file("pacfile.pac")}"
}
resource "azurerm_resource_group" "sita-sig-swa-pacfilehost" {
  name     = var.resgroupname
  location = var.location
  
}

resource "azapi_resource" "pacfilehostswa" {
  type = "Microsoft.Web/staticSites@2022-03-01"
  name = var.name
  location = var.location
  parent_id = azurerm_resource_group.sita-sig-swa-pacfilehost.id
  tags = {
    "Project" = "pacfilehostswa"    
    }
  
  body = jsonencode({
    properties = {
      allowConfigFileUpdates = true
      branch = "main"
      buildProperties = {
        apiBuildCommand = ""
        apiLocation = "/frontend/api"
        appBuildCommand = ""
        appLocation = "/frontend"
        outputLocation = "/frontend/pacfile"
        skipGithubActionWorkflowGeneration = true
      }
      enterpriseGradeCdnStatus = "Disabled"
      provider = ""
      publicNetworkAccess = "Enabled"
      repositoryToken = ""
      repositoryUrl = ""
      stagingEnvironmentPolicy = "Enabled"
      
    }
    sku = {
       name = "Free"
       tier = "Free"
    }
  })
}

resource "azapi_update_resource" "appsetting" {
  type = "Microsoft.Web/staticSites/config@2022-03-01"
  resource_id = "${azapi_resource.pacfilehostswa.id}/config"
  body = local.json_data
  depends_on = [ azapi_resource.pacfilehostswa ]
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