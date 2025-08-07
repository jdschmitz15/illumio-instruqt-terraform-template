terraform {
  required_version = ">=0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    } 
    illumio-cloudsecure = {
      source  = "illumio/illumio-cloudsecure"
      version = ">= 1.0.11"
    }
  }
}

provider "illumio-cloudsecure" {
  client_id     = var.illumio_cloudsecure_client_id
  client_secret = var.illumio_cloudsecure_client_secret

  request_timeout = "60s"
}

provider "aws" {
  region = "us-east-1" 
}


locals  {
  # Extract the account ID prefix from the variable and create a bucket name
  account_id_prefix = replace(split("@", var.account_id)[0],"+","")
  storage_name = "instruqtsa-${local.account_id_prefix}"
}