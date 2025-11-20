resource "azurerm_resource_group" "aks" {
  name     = var.az_resource_group
  location = var.aks_region
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.aks_cluster_name}-dns"
  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_node_vm_size
  }
  identity { type = "SystemAssigned" }
  linux_profile {
    admin_username = "azureuser"
    ssh_key { key_data = "" }
  }
  sku_tier = "Free"
  role_based_access_control {
    enabled = true
  }
  network_profile { network_plugin = "kubenet" }
}

provider "kubernetes" {
  alias = "aks"
  host = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
}

provider "helm" {
  alias = "aks"
  host                   = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
  load_config_file       = false
}

resource "helm_release" "cilium_aks" {
  provider = helm.aks
  name     = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  create_namespace = true
  namespace        = "kube-system"
  values = [<<EOF
kubeProxyReplacement: "strict"
EOF
  ]
}
