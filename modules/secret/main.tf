# Generate random password
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create Secret Manager secret
resource "google_secret_manager_secret" "db_password" {
  secret_id = var.secret_id
  
  replication {
    auto {}
  }
}

# Store the password in Secret Manager
resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = random_password.db_password.result
}

# Grant the GKE service account access to the secret
resource "google_secret_manager_secret_iam_member" "gke_sa_secret_access" {
  secret_id = google_secret_manager_secret.db_password.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.gke_service_account_email}"
}
