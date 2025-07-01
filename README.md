Setup of Git ops using Terraform, Atlantis, Argo CD. 
Github repository: https://github.com/skrish2020/gke2
1. Created the github repository
2. Created the terraform modules for provider GCP to create VPC, SUB NET, NAT Gateway, GKE Clusters in US-CENTRAL1
3. Used terraform init, plan, apply to create the cluster
4. Added terraform module to create a GCE in US Central 1a zone. 
4a. Moved the terraform state file to GCP Bucket
5. Created and deployed an ATLANTIS SERVER on port 4141. Provided access to the same TFState file in the GCP bucket.
6. Create webhook in github repository
7. Successfully test Pull / merge with Atlantis apply (see screenshot Fig 1, 2)
8. Used kubectl to install argocd in GKE nodes
9. Configured github and argocd. 
10. Successfully tested a change to deployment by pushing to github. ArgoCD was able to deploy successfully the updated yaml from github (see screenshot Fig 3)

Opportunities for further optimizations:
a.	Change the kubctl argcd server install to terraform provider based install.
b.	Webhooks to change to github app based webhooks

Fig 1: atlantis.jpg
 



Fig 2:atlantis2.jpg
 
Fig 3:argocd.jpg
 


Appendix:
Plan Atlantis created to destroy the above infrastructure


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
- destroy

Terraform will perform the following actions:

  # google_compute_firewall.allow-iap-ssh will be destroyed
- resource "google_compute_firewall" "allow-iap-ssh" {
      - creation_timestamp      = "2025-06-28T13:33:20.314-07:00" -> null
      - destination_ranges      = [] -> null
      - direction               = "INGRESS" -> null
      - disabled                = false -> null
      - id                      = "projects/rational-talon-463200-f7/global/firewalls/allow-iap-ssh" -> null
      - name                    = "allow-iap-ssh" -> null
      - network                 = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
      - priority                = 1000 -> null
      - project                 = "rational-talon-463200-f7" -> null
      - self_link               = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/firewalls/allow-iap-ssh" -> null
      - source_ranges           = [
          - "35.235.240.0/20",
        ] -> null
      - source_service_accounts = [] -> null
      - source_tags             = [] -> null
      - target_service_accounts = [] -> null
      - target_tags             = [] -> null
        # (1 unchanged attribute hidden)

      - allow {
          - ports    = [
              - "22",
              - "3389",
            ] -> null
          - protocol = "tcp" -> null
        }
    }

  # google_compute_network.vpc will be destroyed
- resource "google_compute_network" "vpc" {
      - auto_create_subnetworks                   = false -> null
      - bgp_always_compare_med                    = false -> null
      - bgp_best_path_selection_mode              = "LEGACY" -> null
      - delete_default_routes_on_create           = true -> null
      - enable_ula_internal_ipv6                  = false -> null
      - id                                        = "projects/rational-talon-463200-f7/global/networks/main" -> null
      - mtu                                       = 0 -> null
      - name                                      = "main" -> null
      - network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL" -> null
      - network_id                                = "7238341587112947584" -> null
      - numeric_id                                = "7238341587112947584" -> null
      - project                                   = "rational-talon-463200-f7" -> null
      - routing_mode                              = "REGIONAL" -> null
      - self_link                                 = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
        # (5 unchanged attributes hidden)
    }

  # google_compute_route.default_route will be destroyed
- resource "google_compute_route" "default_route" {
      - as_paths                   = [] -> null
      - creation_timestamp         = "2025-06-28T13:33:20.182-07:00" -> null
      - dest_range                 = "0.0.0.0/0" -> null
      - id                         = "projects/rational-talon-463200-f7/global/routes/default-route" -> null
      - name                       = "default-route" -> null
      - network                    = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
      - next_hop_gateway           = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/gateways/default-internet-gateway" -> null
      - priority                   = 1000 -> null
      - project                    = "rational-talon-463200-f7" -> null
      - self_link                  = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/routes/default-route" -> null
      - tags                       = [] -> null
      - warnings                   = [] -> null
        # (13 unchanged attributes hidden)
    }

  # google_compute_router.router will be destroyed
- resource "google_compute_router" "router" {
      - creation_timestamp            = "2025-06-28T13:33:20.190-07:00" -> null
      - encrypted_interconnect_router = false -> null
      - id                            = "projects/rational-talon-463200-f7/regions/us-central1/routers/nat-router" -> null
      - name                          = "nat-router" -> null
      - network                       = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
      - project                       = "rational-talon-463200-f7" -> null
      - region                        = "us-central1" -> null
      - self_link                     = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/regions/us-central1/routers/nat-router" -> null
        # (1 unchanged attribute hidden)
    }

  # google_compute_router_nat.nat will be destroyed
- resource "google_compute_router_nat" "nat" {
      - drain_nat_ips                        = [] -> null
      - enable_dynamic_port_allocation       = false -> null
      - enable_endpoint_independent_mapping  = false -> null
      - endpoint_types                       = [
          - "ENDPOINT_TYPE_VM",
        ] -> null
      - icmp_idle_timeout_sec                = 30 -> null
      - id                                   = "rational-talon-463200-f7/us-central1/nat-router/my-router-nat" -> null
      - max_ports_per_vm                     = 0 -> null
      - min_ports_per_vm                     = 0 -> null
      - name                                 = "my-router-nat" -> null
      - nat_ip_allocate_option               = "AUTO_ONLY" -> null
      - nat_ips                              = [] -> null
      - project                              = "rational-talon-463200-f7" -> null
      - region                               = "us-central1" -> null
      - router                               = "nat-router" -> null
      - source_subnetwork_ip_ranges_to_nat   = "ALL_SUBNETWORKS_ALL_IP_RANGES" -> null
      - tcp_established_idle_timeout_sec     = 1200 -> null
      - tcp_time_wait_timeout_sec            = 120 -> null
      - tcp_transitory_idle_timeout_sec      = 30 -> null
      - type                                 = "PUBLIC" -> null
      - udp_idle_timeout_sec                 = 30 -> null
        # (1 unchanged attribute hidden)

      - log_config {
          - enable = true -> null
          - filter = "ERRORS_ONLY" -> null
        }
    }

  # google_compute_subnetwork.private will be destroyed
- resource "google_compute_subnetwork" "private" {
      - creation_timestamp         = "2025-06-28T13:33:20.322-07:00" -> null
      - enable_flow_logs           = false -> null
      - gateway_address            = "10.0.32.1" -> null
      - id                         = "projects/rational-talon-463200-f7/regions/us-central1/subnetworks/private" -> null
      - ip_cidr_range              = "10.0.32.0/19" -> null
      - name                       = "private" -> null
      - network                    = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
      - private_ip_google_access   = true -> null
      - private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS" -> null
      - project                    = "rational-talon-463200-f7" -> null
      - purpose                    = "PRIVATE" -> null
      - region                     = "us-central1" -> null
      - self_link                  = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/regions/us-central1/subnetworks/private" -> null
      - stack_type                 = "IPV4_ONLY" -> null
      - subnetwork_id              = 4912130846549208959 -> null
        # (9 unchanged attributes hidden)

      - secondary_ip_range {
          - ip_cidr_range           = "172.16.0.0/14" -> null
          - range_name              = "k8s-pods" -> null
            # (1 unchanged attribute hidden)
        }
      - secondary_ip_range {
          - ip_cidr_range           = "172.20.0.0/18" -> null
          - range_name              = "k8s-services" -> null
            # (1 unchanged attribute hidden)
        }
    }

  # google_compute_subnetwork.public will be destroyed
- resource "google_compute_subnetwork" "public" {
      - creation_timestamp         = "2025-06-28T13:33:20.230-07:00" -> null
      - enable_flow_logs           = false -> null
      - gateway_address            = "10.0.0.1" -> null
      - id                         = "projects/rational-talon-463200-f7/regions/us-central1/subnetworks/public" -> null
      - ip_cidr_range              = "10.0.0.0/19" -> null
      - name                       = "public" -> null
      - network                    = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/global/networks/main" -> null
      - private_ip_google_access   = true -> null
      - private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS" -> null
      - project                    = "rational-talon-463200-f7" -> null
      - purpose                    = "PRIVATE" -> null
      - region                     = "us-central1" -> null
      - self_link                  = "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/regions/us-central1/subnetworks/public" -> null
      - stack_type                 = "IPV4_ONLY" -> null
      - subnetwork_id              = 4043616746229067647 -> null
        # (9 unchanged attributes hidden)
    }

  # google_container_cluster.gke will be destroyed
- resource "google_container_cluster" "gke" {
      - cluster_ipv4_cidr                        = "172.16.0.0/14" -> null
      - default_max_pods_per_node                = 110 -> null
      - deletion_protection                      = false -> null
      - disable_l4_lb_firewall_reconciliation    = false -> null
      - effective_labels                         = {
          - "goog-terraform-provisioned" = "true"
        } -> null
      - enable_autopilot                         = false -> null
      - enable_cilium_clusterwide_network_policy = false -> null
      - enable_fqdn_network_policy               = false -> null
      - enable_intranode_visibility              = false -> null
      - enable_kubernetes_alpha                  = false -> null
      - enable_l4_ilb_subsetting                 = false -> null
      - enable_legacy_abac                       = false -> null
      - enable_multi_networking                  = false -> null
      - enable_shielded_nodes                    = true -> null
      - enable_tpu                               = false -> null
      - endpoint                                 = "34.121.52.13" -> null
      - id                                       = "projects/rational-talon-463200-f7/locations/us-central1/clusters/gke-cluster1" -> null
      - initial_node_count                       = 1 -> null
      - label_fingerprint                        = "78cdf2f6" -> null
      - location                                 = "us-central1" -> null
      - logging_service                          = "logging.googleapis.com/kubernetes" -> null
      - master_version                           = "1.32.4-gke.1415000" -> null
      - monitoring_service                       = "monitoring.googleapis.com/kubernetes" -> null
      - name                                     = "gke-cluster1" -> null
      - network                                  = "projects/rational-talon-463200-f7/global/networks/main" -> null
      - networking_mode                          = "VPC_NATIVE" -> null
      - node_locations                           = [
          - "us-central1-a",
          - "us-central1-b",
          - "us-central1-c",
        ] -> null
      - node_version                             = "1.32.4-gke.1415000" -> null
      - project                                  = "rational-talon-463200-f7" -> null
      - remove_default_node_pool                 = true -> null
      - resource_labels                          = {} -> null
      - self_link                                = "https://container.googleapis.com/v1/projects/rational-talon-463200-f7/locations/us-central1/clusters/gke-cluster1" -> null
      - services_ipv4_cidr                       = "172.20.0.0/18" -> null
      - subnetwork                               = "projects/rational-talon-463200-f7/regions/us-central1/subnetworks/private" -> null
      - terraform_labels                         = {
          - "goog-terraform-provisioned" = "true"
        } -> null
        # (5 unchanged attributes hidden)

      - addons_config {
          - gce_persistent_disk_csi_driver_config {
              - enabled = true -> null
            }
          - horizontal_pod_autoscaling {
              - disabled = false -> null
            }
          - http_load_balancing {
              - disabled = true -> null
            }
          - network_policy_config {
              - disabled = false -> null
            }
        }

      - binary_authorization {
          - enabled         = false -> null
            # (1 unchanged attribute hidden)
        }

      - cluster_autoscaling {
          - auto_provisioning_locations = [] -> null
          - autoscaling_profile         = "BALANCED" -> null
          - enabled                     = false -> null
        }

      - control_plane_endpoints_config {
          - dns_endpoint_config {
              - allow_external_traffic = false -> null
              - endpoint               = "gke-67ef976f08bf4b3bb41e614ebd4a5a0c0776-420358547028.us-central1.gke.goog" -> null
            }
          - ip_endpoints_config {
              - enabled = true -> null
            }
        }

      - database_encryption {
          - state    = "DECRYPTED" -> null
            # (1 unchanged attribute hidden)
        }

      - default_snat_status {
          - disabled = false -> null
        }

      - enterprise_config {
          - cluster_tier = "STANDARD" -> null
            # (1 unchanged attribute hidden)
        }

      - ip_allocation_policy {
          - cluster_ipv4_cidr_block       = "172.16.0.0/14" -> null
          - cluster_secondary_range_name  = "k8s-pods" -> null
          - services_ipv4_cidr_block      = "172.20.0.0/18" -> null
          - services_secondary_range_name = "k8s-services" -> null
          - stack_type                    = "IPV4" -> null

          - pod_cidr_overprovision_config {
              - disabled = false -> null
            }
        }

      - logging_config {
          - enable_components = [
              - "SYSTEM_COMPONENTS",
              - "WORKLOADS",
            ] -> null
        }

      - master_auth {
          - cluster_ca_certificate = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVMRENDQXBTZ0F3SUJBZ0lRYUh1Y1QyVlJoTWlCUERReVNGaEpHakFOQmdrcWhraUc5dzBCQVFzRkFEQXYKTVMwd0t3WURWUVFERXlRMU5HWTNZbVZpTkMwMU56TXpMVFJoTmpBdFlUbGpZUzAxWWpBME56VTJNek15WmpndwpJQmNOTWpVd05qSTRNVGt6TXpReldoZ1BNakExTlRBMk1qRXlNRE16TkROYU1DOHhMVEFyQmdOVkJBTVRKRFUwClpqZGlaV0kwTFRVM016TXROR0UyTUMxaE9XTmhMVFZpTURRM05UWXpNekptT0RDQ0FhSXdEUVlKS29aSWh2Y04KQVFFQkJRQURnZ0dQQURDQ0FZb0NnZ0dCQUtSQ3o5RFBxVGlHOXY3bjNDdGxEN2FsbndVbDlvb2lwYytoQjN3UgpodVBEd09NNGJIeHE2SVh0QzdtYnFybVlyTHBOL01yNTVXeEVnV2ZzOU5HVmdOTlpWZTkxUk85T01adHp4a21wCjZ2SjdaL1FUQll4RDZQRzFiQm9JUTBCUXE5Y1BqS1RCUTJhYjhiQzR4UDkzbm50K3NHQ2d5YjJxRGFLRlVQcW0KQ2dIUGppOUdzR2ZhMGc4aGpOMlI0cHh6MHFVbUNQU3ZTNWk5R3VhYURTV2tiN2RvSk01RmNDODhpVms2UGlGegoraEprSWRwa3hPTldkYjNzTHh6T0pZd1VTRkQ5dHp1M0pZaTN2QS94OFpMRTZTeVJzSGRRd3dudzRxdzVoYjBsCmZ1RkJhMDA1blFkdElkS01GZ0pOMytUMjl6UHpGRi9EZmtxbTdhaUU1WU02V0h3RXE2eDlzN1JpTkptMysxT0oKQkwvZDJvWHduYk9SWXNIWGgrdDA4UUY1djU1KzdTZkRsc3FPWklXOFVWS1diQ0ZBZjVPdlZJQWZOMnBNVFhhMQpEYnpkZFhNajVDVXhvU1JZNGxOeVlwZGZyQlFkRU5qZ3dHeVo3bVNSU1NtOTUyYW1mckVHcGFMYmVvRE9TM3FlCnZoVDFNSHZ4RlRhUnRsNDZSQURwMyt5bjB3SURBUUFCbzBJd1FEQU9CZ05WSFE4QkFmOEVCQU1DQWdRd0R3WUQKVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVVTZi96TGczb3N2ZThuRDU2emtURG1xSU5ya2d3RFFZSgpLb1pJaHZjTkFRRUxCUUFEZ2dHQkFDUnpQdWRzUUtkRWJZQ3VWdlU4S1F4Z0xWa1lpTWt4VmNlL3c0SmthYVhKClMrSGlGN3ArT2lXcjVwdnhrVnZENWROdXUrVHlUOHRpT1A0ZGNKNVFBOHhJZG1BTWRXODVmSHVqQWUxT3RrVUEKQVNxaDZtV2tWVVh2b0NGamJPMWZhbkFsY2lYemJLSVlDTkg1SDVubFhqamFreW56bTZobmFYTTN3NDlxekZmdQovQnVSV05wMk9KRVZKejV3YTkzN2xhMjBNWkx0a2JLeDVvRW9DYU0zamhGa1lEbDc1N3NKZzducjRiWWlQa1lrCk42RWtoc1ZQZHRaYWxveWRTRlBZc3A0ZGlCQ3hrbWQrZ0F2dzVXSUFNOEh6YlN3RnFFcmFKQS94cnRkQ2UxNFcKZGd5U3pYc0pzR0pnY2dUU0xuaExjYWNuMjY4RUs1R2JzVjVSSzRkS25QOVpoVjJ2VTJaQkRwR21CTWpVeHgzTgpibEF6dUMrRGVqU0pYaC9GYW9LY0wzSk9lS3FyUmQvT1VXZ2xET3NSNFVSUGlpZUpHSHFscXRzYjQzY1FZZGRFCnFvaFRMQ1pXSE1HL1ZhQWR1bU51am5taW56bEJ0Y2xlWjFzM0huK2ozeERKUlVicnZsYW1oYVpuNVptR0lLSkYKZ09YbWVlM0lrOTVLOHorOTcxS1BhQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K" -> null
            # (2 unchanged attributes hidden)

          - client_certificate_config {
              - issue_client_certificate = false -> null
            }
        }

      - monitoring_config {
          - enable_components = [
              - "SYSTEM_COMPONENTS",
              - "JOBSET",
              - "STORAGE",
              - "HPA",
              - "POD",
              - "DAEMONSET",
              - "DEPLOYMENT",
              - "STATEFULSET",
              - "CADVISOR",
              - "KUBELET",
              - "DCGM",
            ] -> null

          - advanced_datapath_observability_config {
              - enable_metrics = false -> null
              - enable_relay   = false -> null
            }

          - managed_prometheus {
              - enabled = true -> null
            }
        }

      - network_policy {
          - enabled  = false -> null
          - provider = "PROVIDER_UNSPECIFIED" -> null
        }

      - node_config {
          - disk_size_gb                = 100 -> null
          - disk_type                   = "pd-balanced" -> null
          - effective_taints            = [] -> null
          - enable_confidential_storage = false -> null
          - flex_start                  = false -> null
          - image_type                  = "COS_CONTAINERD" -> null
          - labels                      = {
              - "role" = "general"
            } -> null
          - local_ssd_count             = 0 -> null
          - logging_variant             = "DEFAULT" -> null
          - machine_type                = "e2-standard-4" -> null
          - metadata                    = {
              - "disable-legacy-endpoints" = "true"
            } -> null
          - oauth_scopes                = [
              - "https://www.googleapis.com/auth/cloud-platform",
              - "https://www.googleapis.com/auth/logging.write",
              - "https://www.googleapis.com/auth/monitoring",
              - "https://www.googleapis.com/auth/trace.append",
            ] -> null
          - preemptible                 = false -> null
          - resource_labels             = {
              - "goog-gke-node-pool-provisioning-model" = "on-demand"
            } -> null
          - resource_manager_tags       = {} -> null
          - service_account             = "gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
          - spot                        = false -> null
          - storage_pools               = [] -> null
          - tags                        = [] -> null
            # (5 unchanged attributes hidden)

          - kubelet_config {
              - allowed_unsafe_sysctls                 = [] -> null
              - container_log_max_files                = 0 -> null
              - cpu_cfs_quota                          = false -> null
              - image_gc_high_threshold_percent        = 0 -> null
              - image_gc_low_threshold_percent         = 0 -> null
              - insecure_kubelet_readonly_port_enabled = "FALSE" -> null
              - pod_pids_limit                         = 0 -> null
                # (5 unchanged attributes hidden)
            }

          - shielded_instance_config {
              - enable_integrity_monitoring = true -> null
              - enable_secure_boot          = false -> null
            }

          - windows_node_config {
                # (1 unchanged attribute hidden)
            }

          - workload_metadata_config {
              - mode = "GKE_METADATA" -> null
            }
        }

      - node_pool {
          - initial_node_count          = 1 -> null
          - instance_group_urls         = [
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-c/instanceGroupManagers/gke-gke-cluster1-general-pool-385a772f-grp",
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-a/instanceGroupManagers/gke-gke-cluster1-general-pool-49583bfe-grp",
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-b/instanceGroupManagers/gke-gke-cluster1-general-pool-653e8ccd-grp",
            ] -> null
          - managed_instance_group_urls = [
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-c/instanceGroups/gke-gke-cluster1-general-pool-385a772f-grp",
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-a/instanceGroups/gke-gke-cluster1-general-pool-49583bfe-grp",
              - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-b/instanceGroups/gke-gke-cluster1-general-pool-653e8ccd-grp",
            ] -> null
          - max_pods_per_node           = 110 -> null
          - name                        = "general-pool" -> null
          - node_count                  = 1 -> null
          - node_locations              = [
              - "us-central1-a",
              - "us-central1-b",
              - "us-central1-c",
            ] -> null
          - version                     = "1.32.4-gke.1415000" -> null
            # (1 unchanged attribute hidden)

          - management {
              - auto_repair  = true -> null
              - auto_upgrade = true -> null
            }

          - network_config {
              - create_pod_range     = false -> null
              - enable_private_nodes = true -> null
              - pod_ipv4_cidr_block  = "172.16.0.0/14" -> null
              - pod_range            = "k8s-pods" -> null
            }

          - node_config {
              - disk_size_gb                = 100 -> null
              - disk_type                   = "pd-balanced" -> null
              - effective_taints            = [] -> null
              - enable_confidential_storage = false -> null
              - flex_start                  = false -> null
              - image_type                  = "COS_CONTAINERD" -> null
              - labels                      = {
                  - "role" = "general"
                } -> null
              - local_ssd_count             = 0 -> null
              - logging_variant             = "DEFAULT" -> null
              - machine_type                = "e2-standard-4" -> null
              - metadata                    = {
                  - "disable-legacy-endpoints" = "true"
                } -> null
              - oauth_scopes                = [
                  - "https://www.googleapis.com/auth/cloud-platform",
                  - "https://www.googleapis.com/auth/logging.write",
                  - "https://www.googleapis.com/auth/monitoring",
                  - "https://www.googleapis.com/auth/trace.append",
                ] -> null
              - preemptible                 = false -> null
              - resource_labels             = {
                  - "goog-gke-node-pool-provisioning-model" = "on-demand"
                } -> null
              - resource_manager_tags       = {} -> null
              - service_account             = "gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
              - spot                        = false -> null
              - storage_pools               = [] -> null
              - tags                        = [] -> null
                # (5 unchanged attributes hidden)

              - kubelet_config {
                  - allowed_unsafe_sysctls                 = [] -> null
                  - container_log_max_files                = 0 -> null
                  - cpu_cfs_quota                          = false -> null
                  - image_gc_high_threshold_percent        = 0 -> null
                  - image_gc_low_threshold_percent         = 0 -> null
                  - insecure_kubelet_readonly_port_enabled = "FALSE" -> null
                  - pod_pids_limit                         = 0 -> null
                    # (5 unchanged attributes hidden)
                }

              - shielded_instance_config {
                  - enable_integrity_monitoring = true -> null
                  - enable_secure_boot          = false -> null
                }

              - windows_node_config {
                    # (1 unchanged attribute hidden)
                }

              - workload_metadata_config {
                  - mode = "GKE_METADATA" -> null
                }
            }

          - upgrade_settings {
              - max_surge       = 1 -> null
              - max_unavailable = 0 -> null
              - strategy        = "SURGE" -> null
            }
        }

      - node_pool_auto_config {
          - resource_manager_tags = {} -> null

          - node_kubelet_config {
              - insecure_kubelet_readonly_port_enabled = "FALSE" -> null
            }
        }

      - node_pool_defaults {
          - node_config_defaults {
              - insecure_kubelet_readonly_port_enabled = "FALSE" -> null
              - logging_variant                        = "DEFAULT" -> null
            }
        }

      - notification_config {
          - pubsub {
              - enabled = false -> null
                # (1 unchanged attribute hidden)
            }
        }

      - pod_autoscaling {
          - hpa_profile = "HPA_PROFILE_UNSPECIFIED" -> null
        }

      - private_cluster_config {
          - enable_private_endpoint     = false -> null
          - enable_private_nodes        = true -> null
          - master_ipv4_cidr_block      = "192.168.0.0/28" -> null
          - private_endpoint            = "192.168.0.2" -> null
          - private_endpoint_subnetwork = "projects/rational-talon-463200-f7/regions/us-central1/subnetworks/gke-gke-cluster1-2dcc5361-pe-subnet" -> null
          - public_endpoint             = "34.121.52.13" -> null
            # (1 unchanged attribute hidden)

          - master_global_access_config {
              - enabled = false -> null
            }
        }

      - release_channel {
          - channel = "REGULAR" -> null
        }

      - secret_manager_config {
          - enabled = false -> null
        }

      - security_posture_config {
          - mode               = "BASIC" -> null
          - vulnerability_mode = "VULNERABILITY_MODE_UNSPECIFIED" -> null
        }

      - service_external_ips_config {
          - enabled = false -> null
        }

      - workload_identity_config {
          - workload_pool = "rational-talon-463200-f7.svc.id.goog" -> null
        }
    }

  # google_container_node_pool.general will be destroyed
- resource "google_container_node_pool" "general" {
      - cluster                     = "projects/rational-talon-463200-f7/locations/us-central1/clusters/gke-cluster1" -> null
      - id                          = "projects/rational-talon-463200-f7/locations/us-central1/clusters/gke-cluster1/nodePools/general-pool" -> null
      - initial_node_count          = 1 -> null
      - instance_group_urls         = [
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-c/instanceGroupManagers/gke-gke-cluster1-general-pool-385a772f-grp",
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-a/instanceGroupManagers/gke-gke-cluster1-general-pool-49583bfe-grp",
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-b/instanceGroupManagers/gke-gke-cluster1-general-pool-653e8ccd-grp",
        ] -> null
      - location                    = "us-central1" -> null
      - managed_instance_group_urls = [
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-c/instanceGroups/gke-gke-cluster1-general-pool-385a772f-grp",
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-a/instanceGroups/gke-gke-cluster1-general-pool-49583bfe-grp",
          - "https://www.googleapis.com/compute/v1/projects/rational-talon-463200-f7/zones/us-central1-b/instanceGroups/gke-gke-cluster1-general-pool-653e8ccd-grp",
        ] -> null
      - max_pods_per_node           = 110 -> null
      - name                        = "general-pool" -> null
      - node_count                  = 1 -> null
      - node_locations              = [
          - "us-central1-a",
          - "us-central1-b",
          - "us-central1-c",
        ] -> null
      - project                     = "rational-talon-463200-f7" -> null
      - version                     = "1.32.4-gke.1415000" -> null
        # (1 unchanged attribute hidden)

      - management {
          - auto_repair  = true -> null
          - auto_upgrade = true -> null
        }

      - network_config {
          - create_pod_range     = false -> null
          - enable_private_nodes = true -> null
          - pod_ipv4_cidr_block  = "172.16.0.0/14" -> null
          - pod_range            = "k8s-pods" -> null
        }

      - node_config {
          - disk_size_gb                = 100 -> null
          - disk_type                   = "pd-balanced" -> null
          - effective_taints            = [] -> null
          - enable_confidential_storage = false -> null
          - flex_start                  = false -> null
          - image_type                  = "COS_CONTAINERD" -> null
          - labels                      = {
              - "role" = "general"
            } -> null
          - local_ssd_count             = 0 -> null
          - logging_variant             = "DEFAULT" -> null
          - machine_type                = "e2-standard-4" -> null
          - metadata                    = {
              - "disable-legacy-endpoints" = "true"
            } -> null
          - oauth_scopes                = [
              - "https://www.googleapis.com/auth/cloud-platform",
              - "https://www.googleapis.com/auth/logging.write",
              - "https://www.googleapis.com/auth/monitoring",
              - "https://www.googleapis.com/auth/trace.append",
            ] -> null
          - preemptible                 = false -> null
          - resource_labels             = {
              - "goog-gke-node-pool-provisioning-model" = "on-demand"
            } -> null
          - resource_manager_tags       = {} -> null
          - service_account             = "gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
          - spot                        = false -> null
          - storage_pools               = [] -> null
          - tags                        = [] -> null
            # (5 unchanged attributes hidden)

          - kubelet_config {
              - allowed_unsafe_sysctls                 = [] -> null
              - container_log_max_files                = 0 -> null
              - cpu_cfs_quota                          = false -> null
              - image_gc_high_threshold_percent        = 0 -> null
              - image_gc_low_threshold_percent         = 0 -> null
              - insecure_kubelet_readonly_port_enabled = "FALSE" -> null
              - pod_pids_limit                         = 0 -> null
                # (5 unchanged attributes hidden)
            }

          - shielded_instance_config {
              - enable_integrity_monitoring = true -> null
              - enable_secure_boot          = false -> null
            }

          - windows_node_config {
                # (1 unchanged attribute hidden)
            }

          - workload_metadata_config {
              - mode = "GKE_METADATA" -> null
            }
        }

      - upgrade_settings {
          - max_surge       = 1 -> null
          - max_unavailable = 0 -> null
          - strategy        = "SURGE" -> null
        }
    }

  # google_project_iam_member.gke_logging will be destroyed
- resource "google_project_iam_member" "gke_logging" {
      - etag    = "BwY4p7OBmGY=" -> null
      - id      = "rational-talon-463200-f7/roles/logging.logWriter/serviceAccount:gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - member  = "serviceAccount:gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - project = "rational-talon-463200-f7" -> null
      - role    = "roles/logging.logWriter" -> null
    }

  # google_project_iam_member.gke_metrics will be destroyed
- resource "google_project_iam_member" "gke_metrics" {
      - etag    = "BwY4p7OBmGY=" -> null
      - id      = "rational-talon-463200-f7/roles/monitoring.metricWriter/serviceAccount:gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - member  = "serviceAccount:gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - project = "rational-talon-463200-f7" -> null
      - role    = "roles/monitoring.metricWriter" -> null
    }

  # google_project_service.api["compute.googleapis.com"] will be destroyed
- resource "google_project_service" "api" {
      - disable_on_destroy = false -> null
      - id                 = "rational-talon-463200-f7/compute.googleapis.com" -> null
      - project            = "rational-talon-463200-f7" -> null
      - service            = "compute.googleapis.com" -> null
    }

  # google_project_service.api["container.googleapis.com"] will be destroyed
- resource "google_project_service" "api" {
      - disable_on_destroy = false -> null
      - id                 = "rational-talon-463200-f7/container.googleapis.com" -> null
      - project            = "rational-talon-463200-f7" -> null
      - service            = "container.googleapis.com" -> null
    }

  # google_project_service.api["logging.googleapis.com"] will be destroyed
- resource "google_project_service" "api" {
      - disable_on_destroy = false -> null
      - id                 = "rational-talon-463200-f7/logging.googleapis.com" -> null
      - project            = "rational-talon-463200-f7" -> null
      - service            = "logging.googleapis.com" -> null
    }

  # google_project_service.api["secretmanager.googleapis.com"] will be destroyed
- resource "google_project_service" "api" {
      - disable_on_destroy = false -> null
      - id                 = "rational-talon-463200-f7/secretmanager.googleapis.com" -> null
      - project            = "rational-talon-463200-f7" -> null
      - service            = "secretmanager.googleapis.com" -> null
    }

  # google_service_account.gke will be destroyed
- resource "google_service_account" "gke" {
      - account_id   = "gke-sa1" -> null
      - description  = "Service account for GKE cluster operations" -> null
      - disabled     = false -> null
      - display_name = "GKE Service Account" -> null
      - email        = "gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - id           = "projects/rational-talon-463200-f7/serviceAccounts/gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - member       = "serviceAccount:gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - name         = "projects/rational-talon-463200-f7/serviceAccounts/gke-sa1@rational-talon-463200-f7.iam.gserviceaccount.com" -> null
      - project      = "rational-talon-463200-f7" -> null
      - unique_id    = "110220808800517912670" -> null
    }

Plan: 0 to add, 0 to change, 16 to destroy.








