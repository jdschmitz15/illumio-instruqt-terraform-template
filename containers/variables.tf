variable "aws_region" { type = string default = "us-east-1" }
variable "eks_cluster_name" { type = string default = "demo-eks-cilium" }
variable "eks_node_group_instance_type" { type = string default = "t3.medium" }
variable "eks_node_count" { type = number default = 2 }

variable "az_resource_group" { type = string default = "rg-aks-cilium-demo" }
variable "aks_cluster_name" { type = string default = "demo-aks-cilium" }
variable "aks_region" { type = string default = "eastus" }
variable "aks_node_count" { type = number default = 2 }
variable "aks_node_vm_size" { type = string default = "Standard_D2s_v3" }
