variable "location" {
  type        = string
  description = "Azureリソースをデプロイするリージョン"
}

variable "resource_group" {
  description = "リソースグループオブジェクト"
  type = object({
    name = string
  })
}

variable "tags" {
  type        = map(string)
  description = "すべてのリソースに適用されるタグ"
}
