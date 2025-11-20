module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 20.0.0"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.28"
  manage_vpc = true
  node_groups = {
    default = {
      desired_capacity = var.eks_node_count
      max_capacity     = var.eks_node_count + 1
      min_capacity     = 1
      instance_type    = var.eks_node_group_instance_type
    }
  }
}

data "aws_eks_cluster" "cluster" { name = module.eks.cluster_id }
data "aws_eks_cluster_auth" "cluster" { name = module.eks.cluster_id }

provider "kubernetes" {
  alias                  = "eks"
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  alias = "eks"
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

resource "helm_release" "cilium_eks" {
  provider       = helm.eks
  name           = "cilium"
  repository     = "https://helm.cilium.io/"
  chart          = "cilium"
  create_namespace = true
  namespace      = "kube-system"
  values = [<<EOF
kubeProxyReplacement: "partial"
EOF
  ]
}
