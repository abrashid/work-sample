terraform {
  required_version = "~> 0.12"
}

provider "aws" {
  profile = "my_profile" # Use credentials in `~/.aws/credentials`
  region  = var.aws_region
  version = "~> 2.23.0"
}


provider "template" {
  version = "~> 2.1.2"
}

module "network" {
  source = "../modules/network"

  project     = var.project
  environment = var.environment
  vpc_id      = var.vpc_id
}