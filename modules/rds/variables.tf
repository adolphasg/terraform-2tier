variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for database deployment"
  type        = list(string)
}

variable "db_name" {
  description = "Initial database name to create"
  type        = string
}

variable "db_username" {
  description = "Master username for RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for RDS instance"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "web_sg_id" {
  description = "Security group ID of the web tier"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}