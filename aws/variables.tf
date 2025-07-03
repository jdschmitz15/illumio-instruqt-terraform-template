variable "illumio_cloudsecure_client_id" {
  type        = string
  description = "The OAuth 2 client identifier used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_id) > 0
    error_message = "The illumio_cloudsecure_client_id value must not be empty."
  }
}

variable "illumio_cloudsecure_client_secret" {
  type        = string
  sensitive   = true
  description = "The OAuth 2 client secret used to authenticate against the CloudSecure Config API."
  validation {
    condition     = length(var.illumio_cloudsecure_client_secret) > 0
    error_message = "The illumio_cloudsecure_client_secret value must not be empty."
  }
}

variable "instance_ami" {
  description = "EC2 instance ami"
  type        = string
  default     = "ami-0182f373e66f89c85"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_availability_zone" {
  description = "Subnet Availablity Zone"
  type        = string
  default     = "us-east-1a"
}

variable "account_id" {
  type        = string
  description = "The account ID for the CloudSecure configuration."
  validation {
    condition     = length(var.account_id) > 0
    error_message = "The account_id value must not be empty."
  }
}