provider "aws" {
  region = "us-east-1" 
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