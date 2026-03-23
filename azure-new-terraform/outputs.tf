output "resource_group_name" {
  value = azurerm_resource_group.sockshop.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.sockshop.name
}

output "acr_login_server" {
  value = azurerm_container_registry.sockshop.login_server
}

output "cosmos_mongo_databases" {
  value = [for db in azurerm_cosmosdb_mongo_database.mongo_db : db.name]
}

output "cosmos_account_name" {
  value = azurerm_cosmosdb_account.mongo.name
}

