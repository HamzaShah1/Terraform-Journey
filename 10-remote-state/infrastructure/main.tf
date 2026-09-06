terraform {
  backend "s3" {
    bucket       = "hamza-learning-tfstate-2026"
    key          = "infrastructure/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }

  }
}

provider "null" {

}

resource "null_resource" "example" {
}