# baseモジュールの変数定義

variable "resource_group" {
  type        = string
  description = "リソースグループ名"
}

variable "location" {
  type        = string
  description = "Azureリージョン"
}

variable "tags" {
  type        = map(string)
  description = "リソースタグ"
}
