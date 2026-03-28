output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Name of the Azure Storage account."
  value       = azurerm_storage_account.static_site.name
}

output "storage_primary_web_host" {
  description = "Hostname of the Azure static website."
  value       = azurerm_storage_account.static_site.primary_web_host
}

output "storage_primary_web_endpoint" {
  description = "Direct endpoint of the Azure static website."
  value       = azurerm_storage_account.static_site.primary_web_endpoint
}