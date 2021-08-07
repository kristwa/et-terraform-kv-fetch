terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.40.0"
    }
  }
}

data "azurerm_key_vault_secret" "source" {
  name      = var.source_secret_name
  vault_uri = var.source_keyvault_uri
}

resource "azurerm_key_vault_secret" "destination" {
  name         = var.destination_secret_name
  key_vault_id = var.destination_keyvault_id
  value        = data.azurerm_key_vault_secret.source.value
}