# resource "google_compute_address" "nat" {
#     name = "nat"
#     address_type = "EXTERNAL"
#     #network_tier = "PREMIUM"

#     depends_on = [ google_project_service.api ]
# }

# resource "google_compute_router" "router" {
#     name = "router"
#     region = var.region
#     network = google_compute_network.vpc.id 
# }

# resource "google_compute_router_nat" "nat" {
#   name = "nat"
#   region = var.region
#   router = google_compute_router.router.name
#   nat_ip_allocate_option = "MANUAL_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
#   nat_ips = [google_compute_address.nat.self_link]

#   subnetwork {
#     name = google_compute_subnetwork.private.self_link
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#   }
# }

## Create Cloud Router

resource "google_compute_router" "router" {

  name    = "nat-router"
  network = google_compute_network.vpc.id
  region  = var.region
}

## Create Nat Gateway

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


 