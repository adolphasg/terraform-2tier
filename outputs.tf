output "web_urls" {
  description = "Web server URLs"
  value       = [for ip in module.web.public_ips : "http://${ip}"]
}

output "rds_endpoint" {
  description = "Database endpoint"
  value       = module.rds.endpoint
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}