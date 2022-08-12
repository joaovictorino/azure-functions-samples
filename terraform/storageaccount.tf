resource "azurerm_storage_account" "upload" {
  name                     = "sauploadfunctionsample"
  resource_group_name      = azurerm_resource_group.azure-functions-sample.name
  location                 = azurerm_resource_group.azure-functions-sample.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
