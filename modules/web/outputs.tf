# Output the ID of the web server security group
output "web_sg_id" {
  value = aws_security_group.web.id
}

# Output the list of public IPs of the web server instances
output "public_ips" {
  value = [for i in aws_instance.web : i.public_ip]
}