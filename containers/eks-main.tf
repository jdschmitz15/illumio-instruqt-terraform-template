module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  # Disable AWS VPC CNI (Cilium takes over)
  cluster_addons = {
    coredns   = { most_recent = true }
    kube-proxy = { most_recent = true }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.large"]
      desired_size   = 2
      min_size       = 2
      max_size       = 4
    }
  }
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = [
      "eks",
      "get-token",
      "--cluster-name", module.eks.cluster_name,
      "--region", var.aws_region,
    ]
  }
}

provider "helm" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name", module.eks.cluster_name,
      "--region", var.aws_region
    ]
  }
}
resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.1"
  namespace  = "kube-system"

  values = [
    yamlencode({
      eni = {
        enabled = true
      }
      ipam = {
        mode = "eni"
      }
      hubble = {
        enabled = true
        relay = {
          enabled = true
        }
        ui = {
          enabled = true
        }
        metrics = {
          enabled = [
            "dns",
            "drop",
            "tcp",
            "flow",
            "icmp",
            "http"
          ]
        }
      }
    })
  ]
}
