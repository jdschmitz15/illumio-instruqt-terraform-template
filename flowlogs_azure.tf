
resource "azurerm_network_watcher" "NetWatcher" {
  name                = "NetworkWatcher_westus"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "random_string" "random" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}
resource "azurerm_storage_account" "flowlogs" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "testdrive-${split("@",var.account_id)[0]}"

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
}