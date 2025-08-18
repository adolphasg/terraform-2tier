# Output the VPC ID created in this configuration
output "vpc_id" {
  value = aws_vpc.this.id
}

# Output the list of public subnet IDs
output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

# Output the list of private subnet IDs
output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}