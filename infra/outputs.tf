output "container_app_url" {
  value = "https://${azurerm_container_app.main.ingress[0].fqdn}"
}