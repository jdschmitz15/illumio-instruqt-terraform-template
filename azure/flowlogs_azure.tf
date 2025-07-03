
resource "azurerm_network_watcher" "NetWatcher" {
  name                = "NetworkWatche${local.account_id_prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_storage_account" "flowlogs" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "${local.storage_name}"

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
}