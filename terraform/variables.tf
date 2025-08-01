variable "resource_group" {
  type        = string
  description = "リソースグループ名"
  default     = "t_toma-test"
}

variable "location" {
  type        = string
  description = "Azureリソースをデプロイするリージョン"
  default     = "Japan East"
}

variable "tags" {
  type        = map(string)
  description = "すべてのリソースに適用されるタグ"
  default = {
    Owner = "t_toma"
  }
}
