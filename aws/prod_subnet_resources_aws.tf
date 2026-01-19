# --------------------------------------------
# -----Create Point-of-sale Prod app----------
# --------------------------------------------
resource "aws_instance" "pos-web01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodwebsg.id]
  private_ip = "10.0.2.21"
  key_name               = aws_key_pair.generated.key_name
  
  tags = {
    Name  = "pos-web01-prd"
    Env = "prod"
    Role = "web"
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
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.22 5000 -t 10 >> /tmp/DB.log") | crontab -
    while true; do nc -l -p 443; done &
  EOF
}

resource "aws_instance" "pos-proc01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodprocsg.id]
  private_ip = "10.0.2.22"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "pos-proc01-prd"
    Env = "prod"
    Role = "processing"
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
    while true; do nc -l -p 5000; done &
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.23 3306 -t 10 >> /tmp/DB.log") | crontab -
  EOF
}

resource "aws_instance" "pos-db01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.proddbsg.id]
  private_ip = "10.0.2.23"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "pos-db01-prd"
    Env = "prod"
    Role = "db"
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
    while true; do nc -l -p 3306; done &
  EOF
}

# --------------------------------------------
# -----Create HR Prod app---------------------
# --------------------------------------------

resource "aws_instance" "hr-web01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodwebsg.id]
  private_ip = "10.0.2.31"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "hr-web01-prd"
    Env = "prod"
    Role = "web"
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
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.32 5000 -t 10 >> /tmp/DB.log") | crontab -
  EOF
}

resource "aws_instance" "hr-proc01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodprocsg.id]
  private_ip = "10.0.2.32"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "hr-proc01-prd"
    Env = "prod"
    Role = "processing"
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
    while true; do nc -l -p 5000; done &
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.33 3306 -t 10 >> /tmp/DB.log") | crontab -
  EOF
}

resource "aws_instance" "hr-db01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.proddbsg.id]
  private_ip = "10.0.2.33"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "hr-db01-prd"
    Env = "prod"
    Role = "db"
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
    while true; do nc -l -p 3306; done &
  EOF
}

# --------------------------------------------
# -----Create CRM Prod app---------------------
# --------------------------------------------

resource "aws_instance" "crm-web01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodwebsg.id]
  private_ip = "10.0.2.41"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "crm-web01-prd"
    Env = "prod"
    Role = "web"
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
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.42 5000 -t 10 >> /tmp/DB.log") | crontab -
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.21 443 -t 10 >> /tmp/DB.log") | crontab -
  EOF
}

resource "aws_instance" "crm-proc01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prodprocsg.id]
  private_ip = "10.0.2.42"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "crm-proc01-prd"
    Env = "prod"
    Role = "processing"
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
    while true; do nc -l -p 5000; done &
    (crontab -l 2>/dev/null || echo ""; echo "* * * * *  telnet 10.0.2.43 3306 -t 10 >> /tmp/DB.log") | crontab -
  EOF
}

resource "aws_instance" "crm-db01-prd" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  availability_zone      = aws_subnet.prod_subnet.availability_zone
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.proddbsg.id]
  private_ip = "10.0.2.43"
  key_name               = aws_key_pair.generated.key_name

  tags = {
    Name  = "crm-db01-prd"
    Env = "prod"
    Role = "db"
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
    while true; do nc -l -p 3306; done &
  EOF
}