variable "project_name" {
  description = "Project name"
  type        = string
  default     = "two-tier"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "web_instance_type" {
  description = "Instance type for web servers"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name (optional)"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "RDS username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed SSH access"
  type        = string
  default     = ""
}

