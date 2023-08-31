output "default_host_name" {
  value       = azapi_resource.pacfilehostswa.name
  description = "The default host name of the Static Web App."
}

output "defaultHostname" {
    value = jsondecode(azapi_resource.pacfilehostswa.output).properties.defaultHostname
    description = "The json output of built static web app"
   }
