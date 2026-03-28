resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "random_string" "storage_suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  resource_group_name  = random_pet.rg_name.id
  storage_account_name = substr(replace("${var.project_name}${random_string.storage_suffix.result}", "-", ""), 0, 24)

  website_files = {
    "index.html" = {
      path         = "${path.module}/../website/index.html"
      content_type = "text/html"
    }
    "style.css" = {
      path         = "${path.module}/../website/style.css"
      content_type = "text/css"
    }
    "script.js" = {
      path         = "${path.module}/../website/script.js"
      content_type = "application/javascript"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "static_site" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true

  static_website {
    index_document     = var.index_document
    error_404_document = var.error_404_document
  }

  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}

resource "azurerm_storage_blob" "website_files" {
  for_each = local.website_files

  name                   = each.key
  storage_account_name   = azurerm_storage_account.static_site.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = each.value.path
  content_type           = each.value.content_type
}