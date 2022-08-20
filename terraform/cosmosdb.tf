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

data "azurerm_cosmosdb_account" "orderscosmosdb" {
  name = "orderscosmosdb" 
  resource_group_name = azurerm_resource_group.azure-functions-sample.name
}

resource "azurerm_cosmosdb_sql_database" "storedb" {
  name                = "store"
  resource_group_name = data.azurerm_cosmosdb_account.orderscosmosdb.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.orderscosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "orders" {
  name                = "orders"
  resource_group_name = data.azurerm_cosmosdb_account.orderscosmosdb.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.orderscosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.storedb.name
  partition_key_path    = "/definition/id"
}
