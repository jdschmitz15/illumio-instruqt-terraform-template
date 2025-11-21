

terraform {
  required_version = ">= 1.5.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
