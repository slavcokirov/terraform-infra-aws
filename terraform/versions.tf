terraform {
  required_version = ">= 0.15.1"

  required_providers {
    aws = {
      version = ">=3.42.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "prod.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-s3-dynamodb"
    encrypt        = true
  }
}
