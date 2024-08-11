resource "azurerm_mssql_server" "zn_web_infra_sql_server" {
  name                         = "${var.sql_name}server"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.vm_db_login_credentials.user
  administrator_login_password = var.vm_db_login_credentials.pass
  depends_on                   = [azurerm_key_vault.zn_web_infra_keyvault]

}


resource "azurerm_mssql_database" "zn_web_infra_sql_db" {
  name           = "${var.sql_name}-db"
  server_id      = azurerm_mssql_server.zn_web_infra_sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
  enclave_type   = "VBS"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

