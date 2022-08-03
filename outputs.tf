output "resource_group_id" {
  value = azurerm_resource_group.demo-rg.id
}

output "service_plan_id" {
  value = azurerm_service_plan.app_plan.id
}