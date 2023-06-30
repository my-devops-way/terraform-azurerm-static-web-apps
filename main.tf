resource "azurerm_resource_group" "example" {
  name     = var.name
  location = var.location
}
resource "azurerm_static_site" "example" {
  name                = var.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

data "azurerm_storage_account_blob_container_sas" "name" {
  connection_string = var.connection_string
  container_name    = var.containername
  start             = "2021-01-01"
  expiry            = "2030-01-01"
  permissions       = "rwdl"  
}

data "azurerm_storage_account" "name" { 
  name = var.containername
  resource_group_name = var.name
  
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

resource "null_resource" "frontend_files"{

    depends_on = [data.azurerm_storage_account_blob_container_sas.website_blob_container_sas, 
                  azurerm_storage_account.resume_static_storage]
      provisioner "local-exec" {
      interpreter = ["/bin/bash", "-c"]
      command = <<EOF
      cd ../frontend
      
      cd build

      azcopy login 
      azcopy copy "./frontend" "${azurerm_storage_account_blob_container_sas.website_blob_container_sas.sas}" --recursive=true
      azcopy copy "./frontend" "${azurerm_storage_account.resume_static_storage.primary_blob_endpoint}" --recursive=true
      EOF
    }
}



