
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
  #account_kind              = "StorageV2"
  account_replication_type  = "LRS"

  blob_properties {
    delete_retention_policy {
    days = 2
    }
  }
}



resource "azurerm_network_watcher_flow_log" "vnetA_flowlogs" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  //network_watcher_name = "NetworkWatcher_westus"
  resource_group_name  = azurerm_resource_group.rg.name
  //resource_group_name = "NetworkWatcherRG"
  name                 = "vnetA-instruqttestdrive-flowlog"

  target_resource_id        = azurerm_virtual_network.vnetA.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  #version = 2

  retention_policy {
    enabled = true
    days    = 2
  }
  depends_on = [ azurerm_network_watcher.NetWatcher,azurerm_resource_group.rg,azurerm_network_security_group.nsg-ticketing-web01-prod,azurerm_network_security_group.nsg-ticketing-web01-dev,azurerm_network_security_group.nsg-ticketing-jump01,azurerm_network_security_group.nsg-ticketing-proc01-prod]  
}


resource "azurerm_network_watcher_flow_log" "vnetB_flowlogs" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  //network_watcher_name = "NetworkWatcher_westus"
  resource_group_name  = azurerm_resource_group.rg.name
  //resource_group_name = "NetworkWatcherRG"
  name                 = "vnetB-instruqttestdrive-flowlog"

  target_resource_id        = azurerm_virtual_network.vnetB.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  #version = 2

  retention_policy {
    enabled = true
    days    = 2
  }
  depends_on = [ azurerm_network_watcher.NetWatcher,azurerm_resource_group.rg,azurerm_network_security_group.nsg-ticketing-web01-prod,azurerm_network_security_group.nsg-ticketing-web01-dev,azurerm_network_security_group.nsg-ticketing-jump01,azurerm_network_security_group.nsg-ticketing-proc01-prod]  
}
