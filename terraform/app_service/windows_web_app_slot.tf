# App Service デプロイメントスロット (develop) - Windows版
resource "azurerm_windows_web_app_slot" "develop_slot" {
  name           = "develop"
  app_service_id = azurerm_windows_web_app.web_app.id
  tags           = var.tags

  # サイト設定（本番と同じ設定）
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
    "SLOT_NAME"                           = "develop"
  }

  # HTTPSのみアクセス許可
  https_only = true
}

# Windows デプロイメントスロット出力値
output "windows_web_app_slot" {
  description = "Windows Development Slot情報"
  value = {
    develop_slot = {
      id               = azurerm_windows_web_app_slot.develop_slot.id
      name             = azurerm_windows_web_app_slot.develop_slot.name
      default_hostname = azurerm_windows_web_app_slot.develop_slot.default_hostname
    }
  }
}
