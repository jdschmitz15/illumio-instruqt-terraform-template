provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "azuread" {
}

resource "azurerm_resource_group" "rg" {
  name     = "testdrive"
  location = "West US"

  tags = {
    environment = "Production"
  }
}
