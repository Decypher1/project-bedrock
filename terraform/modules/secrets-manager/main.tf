resource "random_password" "catalog_db_password" {
  length  = 16
  special = false
}

resource "random_password" "orders_db_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "catalog_db" {
  name = "catalog-db-secret"

  tags = {
    Project = var.project_tag
  }
}

resource "aws_secretsmanager_secret_version" "catalog_db" {
  secret_id = aws_secretsmanager_secret.catalog_db.id

  secret_string = jsonencode({
    username = "catalogadmin"
    password = random_password.catalog_db_password.result
  })
}

resource "aws_secretsmanager_secret" "orders_db" {
  name = "orders-db-secret"

  tags = {
    Project = var.project_tag
  }
}

resource "aws_secretsmanager_secret_version" "orders_db" {
  secret_id = aws_secretsmanager_secret.orders_db.id

  secret_string = jsonencode({
    username = "ordersadmin"
    password = random_password.orders_db_password.result
  })
}