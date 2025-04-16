provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

provider "random" {}

# Enable required GCP APIs
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 13.0"

  project_id = var.project_id
  
  activate_apis = [
    "container.googleapis.com",       # Kubernetes Engine API
    "sqladmin.googleapis.com",        # Cloud SQL Admin API
    "secretmanager.googleapis.com",   # Secret Manager API
    "iam.googleapis.com",             # Identity and Access Management API
    "compute.googleapis.com",         # Compute Engine API (required for networking)
    "servicenetworking.googleapis.com" # Service Networking API (required for private services access)
  ]
  
  disable_services_on_destroy = false
}

# Networking Module
module "networking" {
  source = "./modules/networking"

  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr

  depends_on = [module.project_services]
}

# GKE Module
module "gke" {
  source = "./modules/gke"

  project_id         = var.project_id
  region             = var.region
  cluster_name       = var.cluster_name
  node_count         = var.node_count
  machine_type       = var.machine_type
  disk_size_gb       = var.disk_size_gb
  disk_type          = var.disk_type
  image_type         = var.image_type
  network_id         = module.networking.vpc_id
  subnetwork_id      = module.networking.subnet_id
  pod_range_name     = module.networking.pod_range_name
  service_range_name = module.networking.service_range_name

  depends_on = [module.project_services, module.networking]
}

# Secret Module
module "secret" {
  source = "./modules/secret"

  project_id               = var.project_id
  secret_id                = "postgres-password"
  gke_service_account_email = module.gke.service_account_email

  depends_on = [module.project_services, module.gke]
}

# SQL Module
module "sql" {
  source = "./modules/sql"

  project_id   = var.project_id
  region       = var.region
  db_name      = var.db_name
  db_version   = var.db_version
  db_tier      = var.db_tier
  vpc_id       = module.networking.vpc_id
  db_password  = module.secret.password
  database_name = "app-database"
  user_name    = "app-user"

  # Explicitly depend on the private VPC connection
  depends_on = [
    module.project_services,
    module.networking,
    module.secret,
    module.networking.private_vpc_connection
  ]
}

# RBAC Module
module "rbac" {
  source = "./modules/rbac"

  admin_group     = var.admin_group
  developer_group = var.developer_group

  depends_on = [module.project_services, module.gke]
}
