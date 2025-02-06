#Security Groups for Prod
resource "aws_security_group" "prodwebsg" {
  name        = "Prod-Web-SG"
  vpc_id      = aws_vpc.vpc1.id
   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}


resource "aws_security_group" "prodprocsg" {
  name        = "Prod-Proc-SG"
  vpc_id      = aws_vpc.vpc1.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_security_group" "proddbsg" {
  name        = "Prod-DB-SG"
  vpc_id      = aws_vpc.vpc1.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

#Security Groups for Dev
resource "aws_security_group" "devwebsg" {
  name        = "Dev-Web-SG"
  vpc_id      = aws_vpc.vpc1.id
   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}


resource "aws_security_group" "devprocsg" {
  name        = "Dev-Proc-SG"
  vpc_id      = aws_vpc.vpc1.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_security_group" "devdbsg" {
  name        = "Dev-DB-SG"
  vpc_id      = aws_vpc.vpc1.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

#Security Groups for Stage
resource "aws_security_group" "stagewebsg" {
  name        = "Stage-Web-SG"
  vpc_id      = aws_vpc.vpc2.id
   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}


resource "aws_security_group" "stageprocsg" {
  name        = "Stage-Proc-SG"
  vpc_id      = aws_vpc.vpc2.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_security_group" "stagedbsg" {
  name        = "Stage-DB-SG"
  vpc_id      = aws_vpc.vpc2.id

   ingress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

#Security Groups for Public Subnet
resource "aws_security_group" "publicsg" {
  name        = "Public-SG"
  vpc_id      = aws_vpc.vpc1.id

   ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}