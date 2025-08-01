# App Service (Windows Web App)
resource "azurerm_windows_web_app" "web_app" {
  name                = "apc-training-t-toma-webapp"
  location            = var.location
  resource_group_name = var.resource_group.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  tags                = var.tags

  # サイト設定
  site_config {
    always_on = true

    # .NET 8 (LTS)の設定（Windows用）
    application_stack {
      dotnet_version = "v8.0"
    }

    # HTTPSのみの設定
    http2_enabled = true
  }

  # アプリケーション設定
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  # HTTPSのみアクセス許可
  https_only = true
}

# Windows Web App出力値
output "windows_web_app" {
  description = "Windows Web App情報"
  value = {
    web_app = {
      id                             = azurerm_windows_web_app.web_app.id
      name                           = azurerm_windows_web_app.web_app.name
      default_hostname               = azurerm_windows_web_app.web_app.default_hostname
      possible_outbound_ip_addresses = azurerm_windows_web_app.web_app.possible_outbound_ip_addresses
    }
  }
}
