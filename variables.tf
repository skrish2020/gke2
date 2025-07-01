variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
  default = "rational-talon-463200-f7"
}

variable "region" {
  description = "The Google Cloud region to deploy resources in."
  type        = string
  default = "us-central1"
}  

variable "apis" {
  description = "List of Google Cloud APIs to enable."
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com"
    #"cloudnat.googleapis.com"
  ] 
  
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