output "endpoint" {
  value = aws_db_instance.catalog.endpoint
}

output "database_name" {
  value = aws_db_instance.catalog.db_name
}