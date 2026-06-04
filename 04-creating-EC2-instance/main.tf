terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key = "dev/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }
}

resource "aws_security_group" "web" {
  name = "web-sg"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  user_data = <<-EOF
  #!/bin/bash
  apt update
  apt install -y nginx
  systemctl start nginx
  EOF

  tags = {
    Name = "web-server"
    Environment = "dev"
    ManagedBy = "Terraform"
  }
}

output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}