provider "aws" {
  region     = "us-west-2"
  access_key = "nyan-cat-is-best-cat"  # Hardcoded access key (vulnerability)
  secret_key = "temporary-secret-key-for-dev"  # Hardcoded secret key (vulnerability)
}

# Security Group with overly permissive rules
resource "aws_security_group" "total_recall_sg" {
  name        = "total_recall_sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing all inbound traffic (vulnerability)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing all outbound traffic (vulnerability)
  }
}

# AWS EC2 Instance with Juice Shop app
resource "aws_instance" "total_recall" {
  ami           = "ami-0c55b159cbfafe1f0"  # Use an appropriate AMI ID for your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.total_recall_sg.id]

  # User data to install Docker and run the Juice Shop app
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install docker.io -y
              sudo docker run -d -p 80:3000 bkimminich/total-recall
              EOF

  tags = {
    Name = "JuiceShopInstance"
  }
}

# S3 Bucket without encryption
resource "aws_s3_bucket" "total_recall_bucket" {
  bucket = "total-recall-unencrypted-bucket"
  acl    = "private"  # Unencrypted S3 bucket (vulnerability)
}

# Outputs for demo purposes
output "instance_ip" {
  value = aws_instance.total_recall.public_ip
}
