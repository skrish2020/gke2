resource "google_service_account" "gke" {   
    # Create a service account for GKE
    account_id   = "gke-sa1"
    display_name = "GKE Service Account"
    description  = "Service account for GKE cluster operations"
}

resource "google_project_iam_member" "gke_logging" {
    project = local.project_id
    role    = "roles/logging.logWriter"
    member  = "serviceAccount:${google_service_account.gke.email}"
  
}

resource "google_project_iam_member" "gke_metrics" {
    project = local.project_id
    role    = "roles/monitoring.metricWriter"
    member  = "serviceAccount:${google_service_account.gke.email}"
  
}


resource "google_container_node_pool" "general" {
    name       = "general-pool"
    location   = local.region
    cluster    = google_container_cluster.gke.id
    node_count = 1

    management {
        auto_repair  = true
        auto_upgrade = true
    }


    node_config {
        preemptible = false

        machine_type = "e2-standard-4"
        labels = {
            role = "general"
        }
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform",
            "https://www.googleapis.com/auth/monitoring",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/trace.append"
        ]
        service_account = google_service_account.gke.email
    }


  
}

