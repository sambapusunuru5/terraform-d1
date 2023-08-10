provider "google" {
    credentials = file("credentials.json")
    project = var.project
    region = "us-central1"
}
variable "project" {
  default = "igneous-ethos-389616"
}

variable "instance_count" {
  default = 1
  type = number
}

variable "app" {
  default = "i27academy"
}

variable "environment" {
  default = "dev"
}

#i27academy-dev-bucket

locals {
  instance_type = "n1-standard-2"
  network_tags = ["webserver", "prod-server"]
  bucket-name = "${var.app}-${var.environment}-bucket"
}

// "Name" = "webserver-${count.index}"
resource "google_compute_instance" "tf_my_instance" {
  name = "instance-${count.index + 1}"
  count = var.instance_count
  machine_type = "n1-standard-2"
  tags = local.network_tags
  zone = "us-west4-b"
    boot_disk {
    initialize_params {
        image = "debian-cloud/debian-11"
        labels = {
        my_label = "value"
        }
    }
    }
    network_interface {
      network = "default"
      access_config {
        // ephermerial ip
      }
    }
}

# random

resource "google_storage_bucket" "tf_bucket" {
  name = local.bucket-name
  location = "EU"
}

resource "google_storage_bucket" "tf_bucket_new" {
  name = "devops-batch1-${random_id.tf-bucket-id.dec}"
  location = "EU"
  // gcs or s3 bukcets should be unique across the platforms
}

# defining random provider
resource "random_id" "tf-bucket-id" {
  byte_length = 8
}