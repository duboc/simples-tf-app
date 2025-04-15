output "kubernetes_cluster_name" {
  value       = module.gke.cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_endpoint" {
  value       = module.gke.cluster_endpoint
  description = "GKE Cluster Endpoint"
}

output "database_instance_name" {
  value       = module.sql.instance_name
  description = "Cloud SQL instance name"
}

output "database_connection_name" {
  value       = module.sql.connection_name
  description = "Cloud SQL connection name"
}

output "secret_name" {
  value       = module.secret.secret_name
  description = "Secret Manager secret name"
}

output "vpc_name" {
  value       = module.networking.vpc_name
  description = "VPC Network Name"
}

output "admin_role_binding_name" {
  value       = module.rbac.admin_role_binding_name
  description = "Admin Role Binding Name"
}

output "developer_role_name" {
  value       = module.rbac.developer_role_name
  description = "Developer Role Name"
}
