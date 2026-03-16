variable "location" {
  description = "Azure region"
  default     = "malaysiawest"
}

variable "resource_group_name" {
  default = "sockshop-rg"
}

variable "aks_cluster_name" {
  default = "sockshop-aks"
}

variable "node_count" {
  default = 2
}

variable "node_size" {
  default = "Standard_B2s_v2"

}

# Cosmos DB (Mongo API)
variable "cosmosdb_name_prefix" {
  description = "Cosmos DB account name prefix"
  default     = "sockshop-cosmos"
}

variable "mongo_databases" {
  description = "MongoDB databases"
  default     = ["user-db", "orders-db", "carts-db"]
}
