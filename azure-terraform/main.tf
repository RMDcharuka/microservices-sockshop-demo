resource "azurerm_resource_group" "rg" {
  name     = "dinal-rg"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
   name                = "dinalacr12345"
   resource_group_name = azurerm_resource_group.rg.name
   location            = azurerm_resource_group.rg.location
   sku                 = "Basic"
   admin_enabled       = true 
}
