variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
  default     = "germanywestcentral"
}

variable "project_name" {
  description = "Short project name used in resource naming."
  type        = string
  default     = "clouddemo"
}

variable "resource_group_name_prefix" {
  description = "Prefix for the resource group name."
  type        = string
  default     = "rg-cloud-demo"
}

variable "index_document" {
  description = "Default entry file for the static website."
  type        = string
  default     = "index.html"
}

variable "error_404_document" {
  description = "Error document for missing pages."
  type        = string
  default     = "index.html"
}

variable "tags" {
  description = "Common tags applied to resources."
  type        = map(string)

  default = {
    project     = "cloud-portfolio"
    environment = "poc"
    managedBy   = "terraform"
  }
}