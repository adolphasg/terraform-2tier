# Project name used for resource naming
variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

# ID of the VPC where database resources will be created
variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

# Private subnet IDs for placing the RDS instance
variable "private_subnet_ids" {
  description = "List of private subnet IDs for database deployment"
  type        = list(string)
}

# Initial database name created inside RDS
variable "db_name" {
  description = "Initial database name to create"
  type        = string
}

# Master username for RDS
variable "db_username" {
  description = "Master username for RDS instance"
  type        = string
}

# Master password for RDS (sensitive)
variable "db_password" {
  description = "Master password for RDS instance"
  type        = string
  sensitive   = true
}

# DB instance type/class (e.g., db.t3.micro)
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

# Security group ID of the web tier to allow communication with DB
variable "web_sg_id" {
  description = "Security group ID of the web tier"
  type        = string
}

# Common tags applied to database resources
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}