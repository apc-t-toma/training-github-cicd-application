# App Service デプロイメントスロット (develop)
resource "azurerm_linux_web_app_slot" "develop_slot" {
  name           = "develop"
  app_service_id = azurerm_linux_web_app.web_app.id
  tags           = var.tags

  # サイト設定（本番と同じ設定）
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
    "SLOT_NAME"                           = "develop"
  }

  # HTTPSのみアクセス許可
  https_only = true
}

# デプロイメントスロット出力値
output "linux_web_app_slot" {
  description = "Development Slot情報"
  value = {
    develop_slot = {
      id               = azurerm_linux_web_app_slot.develop_slot.id
      name             = azurerm_linux_web_app_slot.develop_slot.name
      default_hostname = azurerm_linux_web_app_slot.develop_slot.default_hostname
    }
  }
}
