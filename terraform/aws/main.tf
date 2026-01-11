terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "devops-assignment-tf-state-aws"
    key    = "terraform/state/aws.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = var.aws_region
}
