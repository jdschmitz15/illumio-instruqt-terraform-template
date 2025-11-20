output "eks_cluster_name" { value = module.eks.cluster_id }
output "eks_endpoint"    { value = module.eks.cluster_endpoint }
output "aks_cluster_name" { value = azurerm_kubernetes_cluster.aks.name }
output "aks_admin_host"  { value = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host }
