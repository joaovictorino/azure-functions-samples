resource "azurerm_cosmosdb_account" "orderscosmosdb" {
  name                = "orderscosmosdb"
  location            = azurerm_resource_group.azure-functions-sample.location
  resource_group_name = azurerm_resource_group.azure-functions-sample.name
  offer_type          = "Standard"
  enable_automatic_failover = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location = azurerm_resource_group.azure-functions-sample.location
    failover_priority = 0
    zone_redundant = false
  }
}

resource "azurerm_cosmosdb_sql_database" "ordersdb" {
  name                = "ordersdb"
  resource_group_name = azurerm_resource_group.azure-functions-sample.name
  account_name        = azurerm_cosmosdb_account.orderscosmosdb.name
}
