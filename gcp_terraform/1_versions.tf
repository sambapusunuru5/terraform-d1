provider "google" {
  project = "igneous-ethos-389616"
  region = "us-central1-a"
  # pass credentials with file function
  credentials = file("accounts.json")
}

resource "google_compute_network" "tf_gcp_vpc_nw" {
  name = "terraform-nw"
}