# variables.tf

variable "project_id" {
  type        = string
  description = "The GCP project ID."
}

variable "zone" {
  type        = string
  description = "The GCP zone to deploy the instance in."
}

variable "instance_name" {
  type        = string
  description = "The name of the Atlantis instance."
  default     = "atlantis-instance"
}

variable "instance_type" {
  type        = string
  description = "The machine type for the Atlantis instance."
  default     = "e2-medium"
}

variable "image" {
  type        = string
  description = "The image to use for the Atlantis instance.  Recommended: ubuntu-os-cloud/ubuntu-2004-lts"
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "network" {
  type        = string
  description = "The name of the VPC network to deploy the instance in."
  default     = "default"
}

variable "subnetwork" {
  type        = string
  description = "The name of the subnetwork to deploy the instance in."
  default     = "default" # Modify if you are using a custom subnetwork
}


variable "github_app_id" {
  type        = string
  description = "The GitHub App ID."
}

variable "github_app_installation_id" {
  type        = string
  description = "The GitHub App installation ID."
}


variable "atlantis_repo_allowlist" {
  type        = string
  description = "A comma-separated list of GitHub repository patterns to allow Atlantis to manage.  Example: github.com/owner/*,github.com/organization/*"
}

variable "service_account_email" {
  type        = string
  description = "The email address of the service account to attach to the instance."
}

variable "tags" {
  type        = list(string)
  description = "A list of tags to apply to the Atlantis instance and firewall rule."
  default     = ["atlantis"]
}



variable "github_webhook_secret" {
  type        = string
  description = "The GitHub webhook secret."
  sensitive   = true
}


variable "github_private_key" {
  type        = string
  description = "The GitHub App private key."
  sensitive   = true
}
