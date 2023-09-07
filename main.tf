#Terraform Declarations
terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f3e5381e-28a5-4ede-a3c9-6850bac5232f"
}
locals {
    # get json 
    json_data = "${file("staticwebapp.config.json")}"
   # pacfile = "${file("pacfile.pac")}"
}

#Create the Resource Group
resource "azurerm_resource_group" "pacfile_res_group" {
  name     = var.resgroupname
  location = var.location
  
}

 #resource "azurerm_static_site" "swapacfilehost" {
  #name                = var.name
  #resource_group_name = var.resgroupname
  #location            = var.location
#}

#Terraform resource configuration for Static Web App
resource "azapi_resource" "pacfilehostswa" {
 type = "Microsoft.Web/staticSites@2022-03-01"
  name = var.name
  location = var.location
  parent_id = azurerm_resource_group.pacfile_res_group.id
  tags = {
    "Project" = "sigpacfilehostswa"    
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

# Create a variable to hold the JSON data to send to the REST API endpoint.
# This is a Terraform map object, which uses the same format as JSON.
# You can also use the jsonencode() function to convert a Terraform object
# to JSON.

#resource "azapi_update_resource" "appsetting" {
  #type = "Microsoft.Web/staticSites/config@2022-03-01"
  #resource_id = "${azapi_resource.pacfilehostswa.id}/config"
 # body = local.json_data
 # depends_on = [ azapi_resource.pacfilehostswa ]
#}

# Create a CNAME record for the FlexPAC File Host
resource "azurerm_dns_cname_record" "flexpacfilehostcname" {
  name                = var.cname_record
  zone_name           = var.domain
  resource_group_name = var.dnsresourcegroup
  record              = jsondecode(azapi_resource.pacfilehostswa.output).properties.defaultHostname
  ttl                 = 300
}

# Create custom domain name for the static web site
  # that points to the Azure DNS CNAME record that was created
  # in the previous step. This is a required step to map the custom
  # domain name to the Azure storage account hosting the static web site.
resource "azurerm_static_site_custom_domain" "flexpacfilehostcustomdomain" {  
  domain_name     = "${azurerm_dns_cname_record.flexpacfilehostcname.name}.${azurerm_dns_cname_record.flexpacfilehostcname.zone_name}"
  static_site_id  = azapi_resource.pacfilehostswa.id
  validation_type = "cname-delegation"
}