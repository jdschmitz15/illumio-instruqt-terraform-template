resource "azurerm_resource_group" "rg" {
  name     = "testdrive"
  location = "West US"

  tags = {
    environment = "Production"
  }
}
