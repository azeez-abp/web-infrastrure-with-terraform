data "azurerm_client_config" "user" {}

resource "azurerm_key_vault" "zn_web_infra_keyvault" {
  name                = "zn-web-infra-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.user.tenant_id
  access_policy {
    tenant_id = data.azurerm_client_config.user.tenant_id
    object_id = data.azurerm_client_config.user.object_id
    key_permissions = [
      "Get",
      "List",
      "Create"
    ]

    secret_permissions = [
      "Get",
      "List",

    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  }
}



# write the FQDN of sql server into the key fault

resource "azurerm_key_vault_secret" "sql_fqdn" {
  name         = "sql-FQDN"
  value        = azurerm_mssql_server.zn_web_infra_sql_server.fully_qualified_domain_name
  key_vault_id = azurerm_key_vault.zn_web_infra_keyvault.id
}

# Microsoft defender for cloud to log all activities and record all metrics
resource "azurerm_monitor_diagnostic_setting" "zn_web_infra_mdfc" {
  name               = "zn-web-infra-mdfc"
  target_resource_id = azurerm_key_vault.zn_web_infra_keyvault.id
  storage_account_id = azurerm_storage_account.zn_web_infra_storage_acc.id # where log wil be saved

  enabled_log {
    category = "AuditEvent"
  }

  metric {
    category = "AllMetrics"
  }
}
