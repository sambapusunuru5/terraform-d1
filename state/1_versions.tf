# Settings block
terraform {
    required_version = "~> 1.0.8" #contstraints 
    # Terraform providers required
    required_providers {
        aws = { # Local name for the manifest
            # version = ">= 5.1.0"
            version = "~> 4.47.0"
            source = "hashicorp/aws"
            # registry.terraform.io/hashicorp/aws
            # nginx
            # gcr.io/devopswithcloudhub/reponame:tagname
        }
    }
    backend "s3" {
      bucket = "i27academy-tf-devops-b1"
      key = "data/terraform.tfstate"
      region = "us-east-1"
      # Update the lockking mechanism by providing dynamodb table config
      dynamodb_table = "tf-state-table"
    }
}

# Provider info

provider "aws" {
  region = var.region
  profile = "default"
}
