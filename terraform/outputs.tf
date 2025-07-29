# App Service名
output "app_service_name" {
  description = "App Service名"
  value       = module.app_service.linux_web_app.web_app.name
}

# App ServiceのデフォルトURL
output "app_service_default_hostname" {
  description = "App ServiceのデフォルトURL"
  value       = "https://${module.app_service.linux_web_app.web_app.default_hostname}"
}

# App Service developスロットのURL
output "app_service_develop_hostname" {
  description = "App Service developスロットのURL"
  value       = "https://${module.app_service.linux_web_app_slot.develop_slot.default_hostname}"
}

# App Service Plan名
output "app_service_plan_name" {
  description = "App Service Plan名"
  value       = module.app_service.service_plan.app_service_plan.name
}
