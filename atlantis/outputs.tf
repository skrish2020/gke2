# outputs.tf

output "atlantis_instance_name" {
  value       = google_compute_instance.atlantis.name
  description = "The name of the Atlantis instance."
}

output "atlantis_instance_public_ip" {
  value       = google_compute_instance.atlantis.network_interface.0.access_config.0.nat_ip
  description = "The public IP address of the Atlantis instance."
}
