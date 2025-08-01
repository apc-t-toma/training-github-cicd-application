# App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                   = "appplan-windows-t-t-ma"
  location               = var.location
  resource_group_name    = var.resource_group.name
  os_type                = "Windows"
  sku_name               = "S1"
  zone_balancing_enabled = false
  tags                   = var.tags
}

# App Service Plan出力値
output "service_plan" {
  description = "App Service Plan情報"
  value = {
    app_service_plan = {
      id   = azurerm_service_plan.app_service_plan.id
      name = azurerm_service_plan.app_service_plan.name
    }
  }
}
