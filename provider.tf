terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "fraud-detection-terraform-state-12345"  # Change to your real bucket name
    key            = "global/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-1"
}
