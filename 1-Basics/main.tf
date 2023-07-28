
# terraform settings block
terraform {
    # Terraform version needed to execute the manifest file
    required_version = "~> 0.14.5"

    # Terraform providers required
    required_providers {
      aws = {
        version = ">= 5.1.0"
        source = "hashicorp/aws"
      }
    }

    # backend , state file
    backend "s3" {
        bucket  = ""
        region = ""
        key = ""
    }

    # experimental 
    # metadata to providers 

}





# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # north virginia
}


# Configuring Google Provider

provider "google" {
    region      = "us-central1"
}

resource "aws_vpc" "tf-vpcc" {
  
}
