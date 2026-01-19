# Generate SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key locally (NOT in Terraform state)
resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "id_rsa"
  file_permission = "0600"
}

# Create AWS key pair from public key
resource "aws_key_pair" "generated" {
  key_name   = "my-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}