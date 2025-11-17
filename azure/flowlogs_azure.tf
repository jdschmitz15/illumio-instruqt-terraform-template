
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

  depends_on = [azurerm_network_watcher.NetWatcher, azurerm_resource_group.rg,azurerm_network_security_group.nsg-ticketing-web01-prod,azurerm_network_security_group.nsg-ticketing-web01-dev,azurerm_network_security_group.nsg-ticketing-jump01,azurerm_network_security_group.nsg-ticketing-proc01-prod,azurerm_network_security_group.nsg-ticketing-proc01-dev]  
}