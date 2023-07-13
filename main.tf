provider "azurerm" {
  features {}
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

resource "null_resource" "frontend_files"{

    depends_on = [data.azurerm_storage_account_blob_container_sas.container_name_sas, 
                  azurerm_storage_account.pacfilestaticstorage]
      provisioner "local-exec" {
      command = <<EOF
      
      cd ../frontend      
      azcopy login 
      azcopy copy "./frontend" "${data.azurerm_storage_account_blob_container_sas.container_name_sas.connection_string}" --recursive=true
      
      EOF
    }
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