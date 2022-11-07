terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.20.0"
    }
  }
}

data "azurerm_key_vault" "sourcevault" {
  resource_group_name = var.source_keyvault_rg
  name = var.source_keyvault_name
}

data "azurerm_key_vault_secret" "source" {
  name      = var.source_secret_name
  key_vault_id = data.azurerm_key_vault.sourcevault.id
}

resource "azurerm_key_vault_secret" "destination" {
  name         = var.destination_secret_name
  key_vault_id = var.destination_keyvault_id
  value        = data.azurerm_key_vault_secret.source.value
}