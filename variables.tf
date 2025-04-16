variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "gke-network"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "gke-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/20"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "primary-cluster"
}

variable "node_count" {
  description = "Number of nodes per zone"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-standard-2"
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

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "postgres-db"
}

variable "db_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "POSTGRES_14"
}

variable "db_tier" {
  description = "Database machine tier"
  type        = string
  default     = "db-g1-small"
}

variable "admin_group" {
  description = "Google Group for admin access"
  type        = string
  default     = "gke-admins@example.com"
}

variable "developer_group" {
  description = "Google Group for developer access"
  type        = string
  default     = "gke-developers@example.com"
}
