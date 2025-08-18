# Security group for web servers with HTTP/HTTPS and optional SSH access
resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Security group for web servers"
  vpc_id      = var.vpc_id

  # Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Conditionally allow SSH access if key pair and CIDR are provided
  dynamic "ingress" {
    for_each = (var.key_name != "" && var.allow_ssh_cidr != "") ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.allow_ssh_cidr]
    }
  }
  
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# User data script to install and configure nginx
locals {
  user_data = <<-EOF
#!/bin/bash
set -eux
yum update -y
amazon-linux-extras install -y nginx1
systemctl enable nginx
echo "<h1>${var.project_name} Web Server - $$(hostname)</h1>" > /usr/share/nginx/html/index.html
systemctl start nginx
EOF
}

# Create web server instances across public subnets
resource "aws_instance" "web" {
  for_each               = { for idx, subnet_id in var.public_subnet_ids : idx => subnet_id }
  ami                    = data.aws_ami.al2.id
  instance_type          = var.web_instance_type
  subnet_id              = each.value
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = local.user_data
  associate_public_ip_address = true
  key_name               = var.key_name != "" ? var.key_name : null
}