


# # Generate random text for a unique storage account name
# resource "random_id" "random_id" {
#   keepers = {
#     # Generate a new ID only when a new resource group is defined
#     resource_group = azurerm_resource_group.rg.name
#   }

#   byte_length = 8
# }

# # Create storage account for boot diagnostics
# resource "azurerm_storage_account" "my_storage_account" {
#   name                     = "diag${random_id.random_id.hex}"
#   location                 = azurerm_resource_group.rg.location
#   resource_group_name      = azurerm_resource_group.rg.name
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }




# Create virtual machines

resource "azurerm_linux_virtual_machine" "ticketing-web01-dev" {
  name                  = "ticketing-web01-dev"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-A.id]
  size                  = "Standard_B1s"
  disable_password_authentication = false

  os_disk {
    name                 = "ticketing-web01-dev"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = "IyEvYmluL2Jhc2gK4oCLCnN1ZG8geXVtIGluc3RhbGwgdGVsbmV0IC15CuKAiwppZiBbIGAvdXNyL2Jpbi9ob3N0bmFtZWAgPT0gIlRpY2tldGluZy1EZXYtMDEiIF0KdGhlbiAKCXN1ZG8geXVtIGluc3RhbGwgdGVsbmV0IC15CiAgICAgICAgKGNyb250YWIgLWwgMj4vZGV2L251bGwgfHwgZWNobyAiIjsgZWNobyAiKi81ICogKiAqICogIHRlbG5ldCAxMC41MC4xLjUgNTAwMCA+PiAvdG1wL1Byb2MubG9nIikgfCBjcm9udGFiIC0KICAgICAgICAoY3JvbnRhYiAtbCAyPi9kZXYvbnVsbCB8fCBlY2hvICIiOyBlY2hvICIqLzUgKiAqICogKiAgdGVsbmV0IDEwLjUwLjEuNSAyMiA+PiAvdG1wL1Byb2MubG9nIikgfCBjcm9udGFiIC0K4oCLCmZp"
  computer_name  = "ticketing-web01-dev"
  admin_username = "bob"
  admin_password = "Illumio4321!!"
/*
  admin_ssh_key {
    username   = "bob"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
*/
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
  tags = {
    role = "web"
    dept = "222"
    app = "ticketing"
    env = "dev"
    compliance = "pci"
  }
}
resource "azurerm_network_watcher_flow_log" "nw_flowlogs_ticketing-web01-dev" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  //network_watcher_name = "NetworkWatcher_westus"
  resource_group_name  = azurerm_resource_group.rg.name
  //resource_group_name = "NetworkWatcherRG"
  name                 = "nsg-flow-logs-ticketing-web01-dev"

  network_security_group_id = azurerm_network_security_group.nsg-ticketing-web01-dev.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  version = 2

  retention_policy {
    enabled = true
    days    = 1
  }
}
resource "azurerm_network_interface" "nic-A" {
  name                = "nic-A"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-A"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Static"
        private_ip_address = "192.168.1.6"

  }
}
resource "azurerm_network_interface_security_group_association" "assocA" {
  network_interface_id      = azurerm_network_interface.nic-A.id
  network_security_group_id = azurerm_network_security_group.nsg-ticketing-web01-dev.id
}





# Create virtual machine
resource "azurerm_linux_virtual_machine" "ticketing-jump01" {
  name                  = "ticketing-jump01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-C.id]
  size                  = "Standard_B1s"
  disable_password_authentication = false
  

  os_disk {
    name                 = "ticketing-jump01"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = "IyEvYmluL2Jhc2gK4oCLCnN1ZG8geXVtIGluc3RhbGwgdGVsbmV0IC15CuKAiwppZiBbIGAvdXNyL2Jpbi9ob3N0bmFtZWAgPT0gInRpY2tldGluZy1qdW1wMDEiIF0KdGhlbiAKCXN1ZG8geXVtIGluc3RhbGwgdGVsbmV0IC15CiAgICAgICAgKGNyb250YWIgLWwgMj4vZGV2L251bGwgfHwgZWNobyAiIjsgZWNobyAiKi81ICogKiAqICogIHRlbG5ldCAxOTIuMTY4LjEuNiA0NDMgPj4gL3RtcC9Qcm9jLmxvZyIpIHwgY3JvbnRhYiAtCiAgICAgICAgKGNyb250YWIgLWwgMj4vZGV2L251bGwgfHwgZWNobyAiIjsgZWNobyAiKi81ICogKiAqICogIHRlbG5ldCAxOTIuMTY4LjEuNiAyMiA+PiAvdG1wL1Byb2MubG9nIikgfCBjcm9udGFiIC0KICAgICAgICAoY3JvbnRhYiAtbCAyPi9kZXYvbnVsbCB8fCBlY2hvICIiOyBlY2hvICIqLzUgKiAqICogKiAgdGVsbmV0IDE5Mi4xNjguMi42IDQ0MyA+PiAvdG1wL1Byb2MubG9nIikgfCBjcm9udGFiIC0KICAgICAgICAoY3JvbnRhYiAtbCAyPi9kZXYvbnVsbCB8fCBlY2hvICIiOyBlY2hvICIqLzUgKiAqICogKiAgdGVsbmV0IDE5Mi4xNjguMi42IDIyID4+IC90bXAvUHJvYy5sb2ciKSB8IGNyb250YWIgLQrigIsKZmk="
  computer_name  = "ticketing-jump01"
  admin_username = "azruser"
  admin_password = "Illumio4321!!"

  admin_ssh_key {
    username   = "azruser"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
  tags = {
    role = "jump"
    dept = "222"
    app = "ticketing"
    env = "prod"
    compliance = "pci"
  }
}
resource "azurerm_network_watcher_flow_log" "nw_flowlogs_ticketing-jump01" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  //network_watcher_name = "NetworkWatcher_westus"
  resource_group_name  = azurerm_resource_group.rg.name
  //resource_group_name = "NetworkWatcherRG"
  name                 = "nsg-flow-logs-ticketing-jump01"

  network_security_group_id = azurerm_network_security_group.nsg-ticketing-jump01.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  version = 2

  retention_policy {
    enabled = true
    days    = 1
  }
}
resource "azurerm_network_interface" "nic-C" {
  name                = "nic-C"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-C"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Static"
        private_ip_address = "192.168.1.5"
        public_ip_address_id = azurerm_public_ip.JumpIP.id

  }
}
resource "azurerm_network_interface_security_group_association" "assocC" {
  network_interface_id      = azurerm_network_interface.nic-C.id
  network_security_group_id = azurerm_network_security_group.nsg-ticketing-jump01.id
}






resource "azurerm_linux_virtual_machine" "ticketing-web01-prod" {
  name                  = "ticketing-web01-prod"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-B.id]
  size                  = "Standard_B1s"
  disable_password_authentication = false

  os_disk {
    name                 = "ticketing-web01-prod"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "ticketing-web01-prod"
  admin_username = "azruser"
  admin_password = "Illumio4321!!"


  admin_ssh_key {
    username   = "azruser"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
  tags = {
    role = "web"
    dept = "222"
    app = "ticketing"
    env = "prod"
    compliance = "pci"
  }
}
resource "azurerm_network_watcher_flow_log" "nw_flowlogs_ticketing-web01-prod" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  //network_watcher_name = "NetworkWatcher_westus"
  resource_group_name  = azurerm_resource_group.rg.name
  //resource_group_name = "NetworkWatcherRG"
  name                 = "nsg-flow-logs-ticketing-web01-prod"

  network_security_group_id = azurerm_network_security_group.nsg-ticketing-web01-prod.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  version = 2

  retention_policy {
    enabled = true
    days    = 1
  }
}
resource "azurerm_network_interface" "nic-B" {
  name                = "nic-B"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-B"
    subnet_id                     = azurerm_subnet.subnetB.id
    private_ip_address_allocation = "Static"
    private_ip_address = "192.168.2.6"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "assocB" {
  network_interface_id      = azurerm_network_interface.nic-B.id
  network_security_group_id = azurerm_network_security_group.nsg-ticketing-web01-prod.id
}





resource "azurerm_linux_virtual_machine" "ticketing-proc01-prod" {
  name                  = "ticketing-proc01-prod"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic-D.id]
  size                  = "Standard_B1s"
  disable_password_authentication = false

  os_disk {
    name                 = "ticketing-proc01-prod"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "ticketing-proc01-prod"
  admin_username = "azruser"
  admin_password = "Illumio4321!!"

  admin_ssh_key {
    username   = "azruser"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
  tags = {
    role = "proc"
    dept = "222"
    app = "ticketing"
    env = "prod"
    compliance = "pci"
  }
}
resource "azurerm_network_watcher_flow_log" "nw_flowlogs_ticketing-proc01-prod" {
  network_watcher_name = azurerm_network_watcher.NetWatcher.name
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "nsg-flow-logs-ticketing-proc01-prod"

  network_security_group_id = azurerm_network_security_group.nsg-ticketing-proc01-prod.id
  storage_account_id        = azurerm_storage_account.flowlogs.id
  enabled                   = true
  version = 2

  retention_policy {
    enabled = true
    days    = 1
  }
}
resource "azurerm_network_interface" "nic-D" {
  name                = "nic-D"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-D"
    subnet_id                     = azurerm_subnet.subnetB.id
    private_ip_address_allocation = "Static"
    private_ip_address = "192.168.2.7"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "assocD" {
  network_interface_id      = azurerm_network_interface.nic-D.id
  network_security_group_id = azurerm_network_security_group.nsg-ticketing-proc01-prod.id
}


