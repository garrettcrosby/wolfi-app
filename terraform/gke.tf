# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
  name               = "${var.project_id}-gke"
  location           = var.region
  initial_node_count = 2
  node_config {
      machine_type   = "n1-standard-1"
      disk_size_gb   = 10
      preemptible    = true
      tags           = ["gke-node", "${var.project_id}-gke", "wolfi-compute"]
    }
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

