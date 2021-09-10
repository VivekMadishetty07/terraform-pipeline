# Create a Resource Group
resource "azurerm_resource_group" "test" {
  name = "terraform-rg"
  location = var.location
  tags = {
    environment = var.environment
  }
}

resource "azurerm_app_service_plan" "service-plan" {
  name = "vivek-service-plan"
  location = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  kind = "Linux"
  reserved = true
  sku {
    tier = "Basic"
    size = "B1"
  }
  tags = {
    environment = var.environment
  }
}

# Create the App Service
resource "azurerm_app_service" "app_service" {
  name = "vivek-app-service"
  location = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id
  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }
  tags = {
    environment = var.environment
  }
}
