terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.4.0"
    }

    
  }
  backend "s3" {
       bucket = "s3bucket93"
       key    = "minikube"
       region = "us-east-1"
       dynamodb_table ="terraform-lock"
  }
}

provider "aws" {
  # Configuration options
}