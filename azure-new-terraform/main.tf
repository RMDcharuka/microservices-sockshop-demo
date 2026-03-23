resource "random_integer" "unique" {
  min = 1000
  max = 9999
}

# Resource Group
resource "azurerm_resource_group" "sockshop" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry
resource "azurerm_container_registry" "sockshop" {
  name                = "sockshopacr${random_integer.unique.result}"
  location            = azurerm_resource_group.sockshop.location
  resource_group_name = azurerm_resource_group.sockshop.name
  sku                 = "Basic"
  admin_enabled       = true
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "sockshop" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.sockshop.location
  resource_group_name = azurerm_resource_group.sockshop.name
  dns_prefix          = "sockshop"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}

# ---------------resourcecosmos-databse
resource "azurerm_cosmosdb_account" "mongo" {
  name                         = "${lower(var.cosmosdb_name_prefix)}-${random_integer.unique.result}"
  location                     = azurerm_resource_group.sockshop.location
  resource_group_name          = azurerm_resource_group.sockshop.name
  offer_type                   = "Standard"
  kind                         = "MongoDB"

  consistency_policy {
    consistency_level          = "Session"
  }

  geo_location {
    location                   = azurerm_resource_group.sockshop.location
    failover_priority          = 0
  }
}

resource "azurerm_cosmosdb_mongo_database" "mongo_db"  {
  for_each                     = toset(var.mongo_databases)
  name                         = each.value
  resource_group_name          = azurerm_resource_group.sockshop.name
  account_name                 = azurerm_cosmosdb_account.mongo.name
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "sockshop-monitoring-workspace"
  location            = azurerm_resource_group.sockshop.location
  resource_group_name = azurerm_resource_group.sockshop.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

