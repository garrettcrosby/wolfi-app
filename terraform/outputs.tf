# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "dns_zone_name_servers" {
  value       = google_dns_managed_zone.wolfinotes-app.name_servers
  description = "Write these virtual name servers in your base domain."
}

output "domain" {
  value = trim(google_dns_record_set.a.name, ".")
}
