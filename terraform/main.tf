module "vpc" {
  source = "./modules/vpc"

  vpc_name = "project-bedrock-vpc"

  vpc_cidr = "10.0.0.0/16"

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = "project-bedrock-cluster"
  cluster_version = "1.34"

  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
}

module "secrets_manager" {
  source = "./modules/secrets-manager"

  project_tag = "karatu-2025-capstone"
}