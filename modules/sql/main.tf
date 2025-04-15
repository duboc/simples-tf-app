# Cloud SQL PostgreSQL instance
resource "google_sql_database_instance" "postgres" {
  name             = var.db_name
  database_version = var.db_version
  region           = var.region
  
  settings {
    tier = var.db_tier
    
    backup_configuration {
      enabled            = true
      start_time         = "02:00"
      binary_log_enabled = false
    }
    
    maintenance_window {
      day          = 7  # Sunday
      hour         = 3
      update_track = "stable"
    }
    
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
  
  deletion_protection = false  # Set to true for production
}

# Create database
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
}

# Create user
resource "google_sql_user" "user" {
  name     = var.user_name
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}
