output "catalog_secret_arn" {
  value = aws_secretsmanager_secret.catalog_db.arn
}

output "orders_secret_arn" {
  value = aws_secretsmanager_secret.orders_db.arn
}

output "catalog_password" {
  value     = random_password.catalog_db_password.result
  sensitive = true
}

output "orders_password" {
  value     = random_password.orders_db_password.result
  sensitive = true
}