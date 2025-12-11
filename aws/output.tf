output "aws_jump_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.jumphost01.public_ip
}