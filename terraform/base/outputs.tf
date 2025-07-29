# baseモジュールの出力値

output "resource_group" {
  description = "リソースグループ情報"
  value = {
    id   = azurerm_resource_group.t_toma.id
    name = azurerm_resource_group.t_toma.name
  }
}
