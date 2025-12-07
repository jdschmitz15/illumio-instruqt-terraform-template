resource "azurerm_resource_group" "rg" {
  name     = "instruqttestdrive"
  location = "West US"

  tags = {
    environment = "Production"
  }
}
