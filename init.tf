provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {
    bucket  = "tf-webapp-268705"
    prefix  = "terraform/state/portfolio-infra.tfstate"
  }
}