resource "azurerm_resource_group" "example" {
  name     = var.name
  location = var.location
}
resource "azurerm_static_site" "example" {
  name                = var.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
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
