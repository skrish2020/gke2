provider "google" {
  project = local.project_id
  region = local.project_id
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {

        source = "hashicorp/google"
        version = "~> 6.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket  = "skrish2020_tf_state"
    prefix  = "terraform/state"
  }
}