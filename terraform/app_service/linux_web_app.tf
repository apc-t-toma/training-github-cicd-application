# App Service (Web App)
resource "azurerm_linux_web_app" "web_app" {
  name                = "apc-training-t-toma-webapp"
  location            = var.location
  resource_group_name = var.resource_group.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  tags                = var.tags

  # サイト設定
  site_config {
    always_on = true

    # Java 8の設定
    application_stack {
      java_server         = "JAVA"
      java_server_version = "8"
      java_version        = "8"
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

# App Service出力値
output "linux_web_app" {
  description = "Web App情報"
  value = {
    web_app = {
      id                             = azurerm_linux_web_app.web_app.id
      name                           = azurerm_linux_web_app.web_app.name
      default_hostname               = azurerm_linux_web_app.web_app.default_hostname
      possible_outbound_ip_addresses = azurerm_linux_web_app.web_app.possible_outbound_ip_addresses
    }
  }
}
