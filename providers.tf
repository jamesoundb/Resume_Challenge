terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }

  backend "s3" {
    bucket  = "jameswurbel.com-statefile-storage"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    dynamodb_table = "Statefile_lock"
  }


}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}