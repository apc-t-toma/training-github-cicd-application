# Azurermプロバイダーの設定
provider "azurerm" {
  features {}
  subscription_id = "d79e0410-8e3c-4207-8d0a-1f7885d35859"
}

# ベースリソース（リソースグループ）
module "base" {
  source = "./base"

  location       = var.location
  resource_group = var.resource_group
  tags           = var.tags
}

# App Serviceリソース（Web App、App Service Plan）
module "app_service" {
  source = "./app_service"

  location       = var.location
  tags           = var.tags
  resource_group = module.base.resource_group

  depends_on = [module.base]
}
