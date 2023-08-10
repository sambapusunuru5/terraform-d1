# Settings block
terraform {
    required_version = "~> 1.0.8" #contstraints 
    # Terraform providers required
    required_providers {
        google = {
            source = "hashicorp/google"
        }
    }
}

# Provider info
provider "google" {
    # access_key
    # Credentials for GCP
    # gcp sql 
    # aws rds
    # terraform + kubernetes + kubernetes mansifest files

    # Kubernetes >>>> Manifest(kubernetes) >>>> terrfaormmansifets
    credentials = file("credentials.json")
    project = var.project
    region = "us-central1"
}

