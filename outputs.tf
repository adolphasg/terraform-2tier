# Output the public URLs of the web servers
output "web_urls" {
  description = "Web server URLs"
  value       = [for ip in module.web.public_ips : "http://${ip}"]
}

# Output the RDS database endpoint
output "rds_endpoint" {
  description = "Database endpoint"
  value       = module.rds.endpoint
}

# Output the VPC ID created by the VPC module
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}