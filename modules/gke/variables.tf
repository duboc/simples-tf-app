variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes per zone"
  type        = number
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network"
  type        = string
}

variable "subnetwork_id" {
  description = "The ID of the subnetwork"
  type        = string
}

variable "pod_range_name" {
  description = "The name of the secondary IP range for pods"
  type        = string
}

variable "service_range_name" {
  description = "The name of the secondary IP range for services"
  type        = string
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node, specified in GB"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "Type of the disk attached to each node"
  type        = string
  default     = "pd-standard"
}

variable "image_type" {
  description = "The image type to use for the node pool"
  type        = string
  default     = "COS_CONTAINERD"
}
