# Root Terraform settings for this configuration
terraform {
  # Require Terraform CLI v1.6.0 or newer
  required_version = ">= 1.6.0"

  # Use Terraform Cloud as the backend
  cloud {
    # Terraform Cloud organization name
    organization = "two-tier-prod"

    # Target workspace in Terraform Cloud
    workspaces {
      name = "terraform-2tier"
    }
  }

  # Required providers block
  required_providers {
    # Official AWS provider source
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }

    # Random provider for utilities (strings, IDs)
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# AWS provider configuration
provider "aws" {
  # AWS region supplied via variable (e.g., "us-east-1")
  region = var.aws_region
}