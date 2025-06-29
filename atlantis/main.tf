# modules/atlantis/main.tf

resource "google_compute_instance" "atlantis" {
  name                      = var.instance_name
  machine_type              = var.instance_type
  zone                      = var.zone
  project                   = var.project_id

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork_project = var.project_id
    network = var.network
    subnetwork = var.subnetwork

    access_config {
      # Assign a public IP address too the instance.  Remove this block if you
      # only want the instance to be accessible from within the VPC.
    }
  }

  metadata_startup_script = templatefile("${path.module}/templates/startup.sh", {
    github_webhook_secret = var.github_webhook_secret
    github_app_id = var.github_app_id
    github_app_installation_id = var.github_app_installation_id
    github_private_key = var.github_private_key
    atlantis_repo_allowlist = var.atlantis_repo_allowlist
  })

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  tags = var.tags
}

resource "google_compute_firewall" "atlantis" {
  name        = "${var.instance_name}-allow-http-https"
  project     = var.project_id
  network     = var.network
  description = "Allow HTTP and HTTPS traffic to Atlantis"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "4141"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = var.tags
}