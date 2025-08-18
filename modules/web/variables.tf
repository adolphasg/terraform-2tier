# Project name used as a prefix for resources
variable "project_name" { type = string }

# VPC ID where web resources will be created
variable "vpc_id" { type = string }

# List of public subnet IDs for web server placement
variable "public_subnet_ids" { type = list(string) }

# EC2 instance type for web servers
variable "web_instance_type" { type = string }

# EC2 key pair name for SSH access
variable "key_name" { type = string }

# CIDR range allowed for SSH access to web servers
variable "allow_ssh_cidr" { type = string }

# Common tags to apply to all web resources
variable "tags" { type = map(string) }