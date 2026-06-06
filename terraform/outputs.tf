output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "region" {
  value = "us-east-1"
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "catalog_db_endpoint" {
  value = module.rds_mysql.endpoint
}

output "orders_db_endpoint" {
  value = module.rds_postgres.endpoint
}

output "carts_table_name" {
  value = module.dynamodb.table_name
}

output "assets_bucket_name" {
  value = module.serverless.assets_bucket_name
}