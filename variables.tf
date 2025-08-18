# Project name used as a prefix for resources
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "two-tier"
}

# AWS region where resources will be deployed
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# VPC CIDR block for the network
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# CIDR blocks for the public subnets
variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

# CIDR blocks for the private subnets
variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

# EC2 instance type for web servers
variable "web_instance_type" {
  description = "Instance type for web servers"
  type        = string
  default     = "t3.micro"
}

# Optional EC2 key pair name for SSH access
variable "key_name" {
  description = "EC2 key pair name (optional)"
  type        = string
  default     = ""
}

# RDS database username
variable "db_username" {
  description = "RDS username"
  type        = string
  default     = "admin"
}

# RDS database password (sensitive)
variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

# RDS database name
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

# RDS instance type/class
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

# CIDR range allowed for SSH access
variable "allow_ssh_cidr" {
  description = "CIDR allowed SSH access"
  type        = string
  default     = ""
}
