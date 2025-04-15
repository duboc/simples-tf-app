variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_version" {
  description = "PostgreSQL version"
  type        = string
}

variable "db_tier" {
  description = "Database machine tier"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC network"
  type        = string
}

variable "db_password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
  default     = "app-database"
}

variable "user_name" {
  description = "The name of the database user to create"
  type        = string
  default     = "app-user"
}
