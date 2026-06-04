variable "private_subnet_ids" {}

variable "vpc_id" {}

variable "cluster_security_group_id" {}

variable "db_password" {
  sensitive = true
}

variable "project_tag" {
  type = string
}