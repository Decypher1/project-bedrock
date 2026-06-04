resource "aws_db_subnet_group" "this" {
  name = "orders-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Project = var.project_tag
  }
}

resource "aws_security_group" "postgres" {
  name        = "orders-db-sg"
  description = "Orders PostgreSQL access"
  vpc_id      = var.vpc_id

  tags = {
    Project = var.project_tag
  }
}

resource "aws_security_group_rule" "postgres_ingress" {
  type = "ingress"

  from_port = 5432
  to_port   = 5432

  protocol = "tcp"

  security_group_id = aws_security_group.postgres.id

  source_security_group_id = var.cluster_security_group_id
}

resource "aws_db_instance" "orders" {
  identifier = "orders-db"

  engine = "postgres"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "orders"
  username = "ordersadmin"
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.postgres.id
  ]

  publicly_accessible = false

  storage_encrypted = true

  backup_retention_period = 1

  skip_final_snapshot = true

  tags = {
    Project = var.project_tag
  }
}