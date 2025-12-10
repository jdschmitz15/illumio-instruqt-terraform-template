resource "azurerm_resource_group" "rg" {
  name     = "instruqttestdrive"
  location = "West US 2"

  tags = {
    environment = "Production"
  }
}
