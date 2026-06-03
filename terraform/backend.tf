terraform {
  backend "s3" {
    bucket = "bedrock-terraform-state-alt-soe-025-3672"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}