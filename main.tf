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

 #resource "azurerm_static_site" "swapacfilehost" {
  #name                = var.name
  #resource_group_name = var.resgroupname
  #location            = var.location
#}

resource "azapi_resource" "pacfilehostswa" {
 type = "Microsoft.Web/staticSites@2022-03-01"
  name = var.name
  location = var.location
  parent_id = var.resgroupid
  tags = {
    "Project" = "pacfilehostswa"    
    }

   response_export_values = ["*"]
  
  body = jsonencode({
    properties = {
      allowConfigFileUpdates = true
      branch = "Development"
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
      repositoryUrl = "https://github.com/Spyntek/terraform-azurerm-static-web-apps.git"
      stagingEnvironmentPolicy = "Enabled"
      
    }
    sku = {
       name = "Free"
       tier = "Free"
    }
  })
}

#resource "azapi_update_resource" "appsetting" {
 # type = "Microsoft.Web/staticSites/config@2022-03-01"
 # resource_id = "${azapi_resource.pacfilehostswa.id}/config"
 # body = local.json_data
 # depends_on = [ azapi_resource.pacfilehostswa ]
#}

resource "azurerm_dns_cname_record" "flexpacfilehostcname" {
  name                = var.cname_record
  zone_name           = var.domain
  resource_group_name = var.dnsresourcegroup
  record              = jsondecode(azapi_resource.pacfilehostswa.output).properties.defaultHostname
  ttl                 = 300
}

resource "azurerm_static_site_custom_domain" "flexpacfilehostcustomdomain" {
  domain_name     = "${azurerm_dns_cname_record.flexpacfilehostcname.name}.${azurerm_dns_cname_record.flexpacfilehostcname.zone_name}"
  static_site_id  = azapi_resource.pacfilehostswa.id
  validation_type = "cname-delegation"
}