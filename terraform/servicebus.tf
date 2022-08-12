resource "azurerm_servicebus_namespace" "servicebus-functions" {
  name                = "namespace-functions"
  location            = azurerm_resource_group.azure-functions-sample.location
  resource_group_name = azurerm_resource_group.azure-functions-sample.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "ordersmq" {
  name         = "ordersmq"
  namespace_id = azurerm_servicebus_namespace.servicebus-functions.id

  enable_partitioning = true
}
