# Define local values used across resources
locals {
  # Common tags applied to resources
  common_tags = {
    Project = var.project_name
    Managed = "terraform"
  }
}

# Generate a random string to use as a suffix for unique naming
resource "random_string" "suffix" {
  length  = 6     # 6 characters long
  upper   = false # no uppercase letters
  special = false # no special characters
}

# VPC module for networking setup
module "vpc" {
  source               = "./modules/vpc" # Path to VPC module
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags
}

# Web module for EC2 web server provisioning
module "web" {
  source            = "./modules/web" # Path to Web module
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  web_instance_type = var.web_instance_type
  key_name          = var.key_name
  allow_ssh_cidr    = var.allow_ssh_cidr
  tags              = local.common_tags
}

# RDS module for relational database setup
module "rds" {
  source             = "./modules/rds" # Path to RDS module
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
  web_sg_id          = module.web.web_sg_id
  tags               = local.common_tags
}