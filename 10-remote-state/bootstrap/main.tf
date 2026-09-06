resource "aws_s3_bucket" "terraform_state" {
  bucket = "hamza-learning-tfstate-2026"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# configure provider
provider "aws" {
  region = "eu-west-2"
}