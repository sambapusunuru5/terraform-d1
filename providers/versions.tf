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
        google = {
            source = "hashicorp/google"
        }

    }
}

# Provider info

provider "aws" {
  region = "us-east-1"
  profile = "default"
  access_key = "AKIAQIRZP7EEEIF225EQ"
  secret_key = "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"
}

# Provider other info
provider "aws" {
  region = "us-west-1"
  profile = "myprofile"  # we can change this profile name by vim ~/.aws/credentials   create another name and we pass that name in profile
  alias = "aws-west-1"
}
