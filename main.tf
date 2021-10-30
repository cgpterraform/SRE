#DNS Server

#Load balancer
#Got this from: https://cloud.google.com/load-balancing/docs/https/ext-http-lb-tf-module-examples
#Didn't have time to set iy up to my network.
# VPC
# resource "google_compute_network" "default" {
#   name                    = "l7-xlb-network"
#   provider                = google
#   auto_create_subnetworks = false
# }

# # backend subnet
# resource "google_compute_subnetwork" "default" {
#   name          = "l7-xlb-subnet"
#   provider      = google
#   ip_cidr_range = "10.0.1.0/24"
#   region        = "us-central1"
#   network       = google_compute_network.default.id
# }

# # reserved IP address
# resource "google_compute_global_address" "default" {
#   name = "l7-xlb-static-ip"
# }

# # forwarding rule
# resource "google_compute_global_forwarding_rule" "default" {
#   name                  = "l7-xlb-forwarding-rule"
#   provider              = google
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL"
#   port_range            = "80"
#   target                = google_compute_target_http_proxy.default.id
#   ip_address            = google_compute_global_address.default.id
# }

# # http proxy
# resource "google_compute_target_http_proxy" "default" {
#   name     = "l7-xlb-target-http-proxy"
#   provider = google
#   url_map  = google_compute_url_map.default.id
# }

# # url map
# resource "google_compute_url_map" "default" {
#   name            = "l7-xlb-url-map"
#   provider        = google
#   default_service = google_compute_backend_service.default.id
# }

# # backend service with custom request and response headers
# resource "google_compute_backend_service" "default" {
#   name                     = "l7-xlb-backend-service"
#   provider                 = google-beta
#   protocol                 = "HTTP"
#   port_name                = "my-port"
#   load_balancing_scheme    = "EXTERNAL"
#   timeout_sec              = 10
#   enable_cdn               = true
#   custom_request_headers   = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
#   custom_response_headers  = ["X-Cache-Hit: {cdn_cache_status}"]
#   health_checks            = [google_compute_health_check.default.id]
#   backend {
#     group           = google_compute_instance_group_manager.default.instance_group
#     balancing_mode  = "UTILIZATION"
#     capacity_scaler = 1.0
#   }
# }

# # instance template
# resource "google_compute_instance_template" "default" {
#   name         = ""
#   provider     = google
#   machine_type = ""
#   tags         = ["allow-health-check"]

#   network_interface {
#     network    = ""
#     subnetwork = ""
#     access_config {
#       # add external ip to fetch packages
#     }
#   }
#   disk {
#     source_image = "debian-cloud/debian-10"
#     auto_delete  = true
#     boot         = true
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# # health check
# resource "google_compute_health_check" "default" {
#   name     = ""
#   provider = google
#   http_health_check {
#     port_specification = "USE_SERVING_PORT"
#   }
# }

# # MIG
# resource "google_compute_instance_group_manager" "default" {
#   name     = ""
#   provider = google
#   zone     = ""
#   named_port {
#     name = "http"
#     port = 8080
#   }
#   version {
#     instance_template = google_compute_instance_template.default.id
#     name              = "primary"
#   }
#   base_instance_name = "vm"
#   target_size        = 2
# }

# # allow access from health check ranges
# resource "google_compute_firewall" "default" {
#   name          = ""
#   provider      = google
#   direction     = "INGRESS"
#   network       = google_compute_network.default.id
#   source_ranges = ["", ""]
#   allow {
#     protocol = "tcp"
#   }
#   target_tags = ["allow-health-check"]
# }