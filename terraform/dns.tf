variable "base_domain" {
  type        = string
  description = "Your base domain"
}

variable "name" {
  type        = string
  description = "Name of resources"
  default     = "wolfinotes-app"
}

data "google_client_config" "current" {}

resource "google_compute_global_address" "default" {
  name = var.name
}

resource "google_dns_managed_zone" "wolfinotes-app" {
  name        = "wolfinotes-app"
  dns_name    = "wolfinotes.app."
  description = "DNS Zone for wolfinotes.app"
  
}

resource "google_dns_record_set" "a" {
  name         = google_dns_managed_zone.wolfinotes-app.dns_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.wolfinotes-app.name

  rrdatas = [google_compute_global_address.default.address]
}

resource "google_dns_record_set" "cname" {
  name         = join(".", compact(["www", google_dns_record_set.a.name]))
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.wolfinotes-app.name

  rrdatas = [google_dns_record_set.a.name]
}

