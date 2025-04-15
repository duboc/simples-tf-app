variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "secret_id" {
  description = "The ID of the secret"
  type        = string
  default     = "postgres-password"
}

variable "gke_service_account_email" {
  description = "The email of the GKE service account that needs access to the secret"
  type        = string
}
