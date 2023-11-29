# main.tf

provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create VPC
resource "aws_vpc" "personal_site_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "personal-site-vpc"
    Project = "personal-site"
  }
}

# Create subnet in the VPC
resource "aws_subnet" "personal_website_subnet" {
  vpc_id                  = aws_vpc.personal_site_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"  # Replace with your desired availability zone

  tags = {
    Name = "perosnal-site-subnet"
    Project = "personal-site"
  }
}

resource "aws_internet_gateway" "personal_site_internet_gateway" {
  vpc_id = aws_vpc.personal_site_vpc.id

  tags = {
    Name = "personal-site-gw"
    Project = "personal-site"

  }
}

resource "aws_route_table" "personal_site_route_table" {
  vpc_id = aws_vpc.personal_site_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.personal_site_internet_gateway.id
  }

  tags = {
    Name = "personal-site-route-table"
    Project = "personal-site"
  }

}


resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.personal_website_subnet.id
  route_table_id = aws_route_table.personal_site_route_table.id
}


# Create security group for the instance
resource "aws_security_group" "svelte_security_group" {
    name = "personal-site-sg"
    description = "Security group for an ec2 devoted to site"
  vpc_id = aws_vpc.svelte_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22  # Allow SSH for maintenance
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["98.207.205.66/32"]
  }

  tags = {
    Name = "peronal-site-security-group"
    Projecgt = "personal-site"
  }
}



resource "aws_instance" "svelte_instance" {
  ami           = "ami-0230bd60aa48260c6"  
  instance_type = "t2.micro"
  key_name      = "PersonalSiteEC2"  # Replace with the key pair name you created

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo apt install -y nodejs npm
              git clone https://github.com/manyshapes/personal-site ps-app
              cd ps-app
              npm install
              npm run build
              npm start
              EOF

  tags = {
    Name = "svelte-instance"
  }
}
