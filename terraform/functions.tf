resource "azurerm_storage_account" "apifunctionsa" {
  name                     = "apifunctionsa"
  resource_group_name      = azurerm_resource_group.azure-functions-sample.name
  location                 = azurerm_resource_group.azure-functions-sample.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "apifunction" {
  name                    = "countingfunction-premiumPlan"
  resource_group_name     = azurerm_resource_group.azure-functions-sample.name
  location                = azurerm_resource_group.azure-functions-sample.location
  os_type                 = "Linux"
  sku_name                = "Y1"
}

resource "azurerm_linux_function_app" "api-function-orders" {
    name                        = "api-function-orders"
    location                    = azurerm_resource_group.azure-functions-sample.location
    resource_group_name         = azurerm_resource_group.azure-functions-sample.name
    storage_account_name        = azurerm_storage_account.apifunctionsa.name
    storage_account_access_key = azurerm_storage_account.apifunctionsa.primary_access_key 
    service_plan_id             = azurerm_service_plan.apifunction.id
    functions_extension_version = "~4"

    site_config {
        application_stack {
            node_version = "16"
        }
    }
}
