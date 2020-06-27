variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"

}

resource "google_dns_managed_zone" "danielchoime" {
  name        = "danielchoime-zone"
  dns_name    = "danielchoi.me."
  description = "DNS zone for danielchoi.me"
}

resource "google_dns_record_set" "root" {
  name = google_dns_managed_zone.danielchoime.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.danielchoime.name

  rrdatas = [kubernetes_service.portfolio-frontend-service.load_balancer_ingress[0].ip]
}



output "region" {
  value       = var.region
  description = "region"
}
