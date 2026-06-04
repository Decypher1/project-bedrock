resource "aws_db_subnet_group" "this" {
  name = "catalog-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Project = var.project_tag
  }
}

resource "aws_security_group" "mysql" {
  name        = "catalog-db-sg"
  description = "Catalog MySQL access"
  vpc_id      = var.vpc_id

  tags = {
    Project = var.project_tag
  }
}

resource "aws_security_group_rule" "mysql_ingress" {
  type = "ingress"

  from_port = 3306
  to_port   = 3306

  protocol = "tcp"

  security_group_id = aws_security_group.mysql.id

  source_security_group_id = var.cluster_security_group_id
}

resource "aws_db_instance" "catalog" {
  identifier = "catalog-db"

  engine         = "mysql"
  engine_version = "8.0.41"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "catalog"
  username = "catalogadmin"
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    aws_security_group.mysql.id
  ]

  publicly_accessible = false

  skip_final_snapshot = true

  tags = {
    Project = var.project_tag
  }
}