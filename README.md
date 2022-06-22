# terraform-azurerm-static-web-apps
This is an example to create an azure static web app using terraform azurem provider.

** NOTE: THIS IS NOT A MODULE

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_static_site.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_site) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The Domain Name which should be associated with this Static Site. | `string` | `"my.domain.com"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Static Web App should exist. | `string` | `"East US 2"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name which should be used for this Static Web App and the Resources Group | `string` | `"example"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_host_name"></a> [default\_host\_name](#output\_default\_host\_name) | The default host name of the Static Web App. |
<!-- END_TF_DOCS -->
