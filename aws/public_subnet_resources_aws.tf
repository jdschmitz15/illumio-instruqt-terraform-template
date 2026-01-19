#Create Jumpbox on Public Subnet
resource "aws_instance" "jumphost01" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.public_subnet.availability_zone
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.publicsg.id]
  private_ip = "10.0.1.10"
  key_name               = aws_key_pair.generated.key_name
  
  tags = {
    Name  = "jumphost01"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemct enable httpd
    sudo yum install telnet -y
    sudo yum install cronie -y
    sudo systemctl enable crond.service
    sudo systemctl start crond.service
    sudo yum install nc -y
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.21 22 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.33 3306 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.10.4.43 3306 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.3.33 3306 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.3.23 3306 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.43 3306 -t 10 >> /tmp/DB.log") | crontab -
  EOF

  #  user_data = <<-EOF
  #   #!/bin/bash
  #   sudo yum update -y
  #   sudo yum install -y httpd
  #   sudo systemctl start httpd
  #   sudo systemct enable httpd
  #   sudo yum install telnet -y
  #   sudo yum install cronie -y
  #   sudo systemctl enable crond.service
  #   sudo systemctl start crond.service
  #   sudo yum install nc -y
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.21 22 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.33 3306 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.10.4.43 3306 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.3.33 3306 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.3.23 3306 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.43 3306 -t 10 >> /tmp/DB.log") | crontab -
  #   (crontab -l 2>/dev/null || echo ""; echo "* * * * *  ${azurerm_linux_virtual_machine.ticketing-jump01.public_ip_address}"  22 -t 10 >> /tmp/DB.log") | crontab -
  # EOF
}