terraform {
    required_version = "~> 1.0.8" #contstraints 
    # Terraform providers required
    
    required_providers {
        aws = {
            # version = ">= 5.1.0"
            version = "~> 4.47.0"
            source = "hashicorp/aws"
        }
        google = {
            source = "hashicorp/google"
        }
    }
}

# Providers 
provider "aws" {

  # credentials
}

provider "google" {
  
}

