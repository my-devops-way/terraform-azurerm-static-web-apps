variable "name" {
  type        = string
  default     = "example"
  description = "The name which should be used for this Static Web App and the Resources Group"
}
variable "domain" {
  type        = string
  default     = "my.domain.com"
  description = "The Domain Name which should be associated with this Static Site."
}
variable "location" {
  type        = string
  default     = "East US 2"
  description = "The Azure Region where the Static Web App should exist."
}
