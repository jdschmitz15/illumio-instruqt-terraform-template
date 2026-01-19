# Generate SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

# Save private key locally (NOT in Terraform state)
resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  
  filename = "$${HOME}/.ssh/${random_pet.ssh_key_name.id}"
  file_permission = "0600"
}

# Create AWS key pair from public key
resource "aws_key_pair" "generated" {
  key_name   = "my-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# // filepath: /Users/jeff.schmitz/go/src/github.com/jdschmitz15/illumio-instruqt-terraform-template/aws/ssh_key.tf
# resource "aws_key_pair" "tempkey" {
#   key_name   = "tempkey"
#   public_key = file("/root/illumio-instruqt-terraform-template/aws/tempkey.pub")
# }