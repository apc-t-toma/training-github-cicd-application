# リソースグループ
resource "azurerm_resource_group" "t_toma" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}
