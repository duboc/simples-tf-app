output "secret_id" {
  description = "The ID of the secret"
  value       = google_secret_manager_secret.db_password.id
}

output "secret_name" {
  description = "The name of the secret"
  value       = google_secret_manager_secret.db_password.name
}

output "password" {
  description = "The generated password"
  value       = random_password.db_password.result
  sensitive   = true
}
