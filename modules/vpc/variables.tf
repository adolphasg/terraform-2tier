# Project name used as a prefix for resources
variable "project_name" { type = string }

# VPC CIDR block for the network
variable "vpc_cidr" { type = string }

# CIDR blocks for the public subnets
variable "public_subnet_cidrs" { type = list(string) }

# CIDR blocks for the private subnets
variable "private_subnet_cidrs" { type = list(string) }

# Common tags to apply to all resources
variable "tags" { type = map(string) }