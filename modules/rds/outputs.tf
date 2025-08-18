# Output the RDS database endpoint address
output "endpoint" {
  value = aws_db_instance.mysql.address
}