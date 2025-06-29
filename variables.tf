variable "project_id" {
  type        = string
  description = "The GCP project ID."
}

variable "region" {
  type        = string
  description = "The GCP project region."
}

variable "apis" {
  type        = list(string)
  description = "List of GCP APIs to enable for the project."
}


/*
locals {
    project_id = "rational-talon-463200-f7"
    region = "us-central1"
    apis = [
        "compute.googleapis.com",
        "container.googleapis.com",
        "logging.googleapis.com",
        "secretmanager.googleapis.com"
        #"cloudnat.googleapis.com"
    ]
}
*/