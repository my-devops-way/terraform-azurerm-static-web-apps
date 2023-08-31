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
  default     = "East US"
  description = "The Azure Region where the Static Web App should exist."
}

variable "connection_string" {
  type        = string
  description = "The connection string for the storage account."
}

variable "resgroupname" {
  type        = string
  description = "The name of the resource group."
}

variable "applocation" {
  type        = string
  description = "The name of the app location."
}

variable "cname_record" {
  type        = string
  description = "The name of the cname record."
}
variable "dnsresourcegroup" {
  type        = string
  description = "The name of the dns resource group."
}
variable "resgroupid" {
  type        = string
  description = "The id of the resource group."
}