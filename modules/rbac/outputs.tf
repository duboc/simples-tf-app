output "admin_role_binding_name" {
  description = "The name of the admin role binding"
  value       = kubernetes_cluster_role_binding.admin.metadata[0].name
}

output "developer_role_name" {
  description = "The name of the developer role"
  value       = kubernetes_cluster_role.developer.metadata[0].name
}

output "developer_role_binding_name" {
  description = "The name of the developer role binding"
  value       = kubernetes_cluster_role_binding.developer.metadata[0].name
}
