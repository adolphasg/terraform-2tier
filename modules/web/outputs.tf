output "web_sg_id" {
  value = aws_security_group.web.id
}

output "public_ips" {
  value = [for i in aws_instance.web : i.public_ip]
}