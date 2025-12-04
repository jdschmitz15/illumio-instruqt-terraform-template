resource "azurerm_resource_group" "rg" {
  name     = "instruqttestdrive"
  location = "East US"

  tags = {
    environment = "Production"
  }
}
