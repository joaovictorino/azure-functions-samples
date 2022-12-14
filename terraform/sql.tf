resource "azurerm_mssql_server" "orderssrv" {
  name                         = "orderssrv"
  resource_group_name          = azurerm_resource_group.azure-functions-sample.name
  location                     = azurerm_resource_group.azure-functions-sample.location
  version                      = "12.0"
  administrator_login          = "sampleuser"
  administrator_login_password = "Teste@admin123"
}

resource "azurerm_mssql_database" "ordersdb" {
  name           = "ordersdb"
  server_id      = azurerm_mssql_server.orderssrv.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  
  auto_pause_delay_in_minutes = 60
  max_size_gb                 = 32
  min_capacity                = 0.5
  read_replica_count          = 0
  read_scale                  = false
  sku_name                    = "GP_S_Gen5_1"
  zone_redundant              = false

  threat_detection_policy {
      disabled_alerts      = []
      email_account_admins = "Disabled"
      email_addresses      = []
      retention_days       = 0
      state                = "Disabled"
  }
}

resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = "azureaccess"
  server_id        = azurerm_mssql_server.orderssrv.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
