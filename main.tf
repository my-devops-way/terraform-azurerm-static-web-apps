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
    #pacfile = "${file("pacfile.pac")}"
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
        appLocation = "/frontend/build"
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

output "default_hostname" {
  value = jsondecode(azapi_resource.pacfilehostswa.output).properties.defaultHostname
  depends_on = [ azapi_resource.pacfilehostswa ]
}

resource "azapi_update_resource" "appsetting" {
  type = "Microsoft.Web/staticSites/config@2022-03-01"
  resource_id = "${azapi_resource.pacfilehostswa.id}/config"
  body = local.json_data
  depends_on = [ azapi_resource.pacfilehostswa ]
}
resource "azurerm_static_site_custom_domain" "flexpacfilehostcustomdomain" {
  domain_name     = "${azurerm_dns_cname_record.flexpacfilehostcname.name}.${azurerm_dns_cname_record.flexpacfilehostcname.zone_name}"
  static_site_id  = azapi_resource.pacfilehostswa.id
  validation_type = "cname-delegation"
}
resource "azurerm_dns_cname_record" "flexpacfilehostcname" {
  name                = var.cname_record
  zone_name           = var.domain
  resource_group_name = var.resgroupname
  ttl                 = 300
  record              = azapi_resource.pacfilehostswa.output
  }