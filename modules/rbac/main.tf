# Kubernetes Admin ClusterRole binding
resource "kubernetes_cluster_role_binding" "admin" {
  metadata {
    name = "gke-admin-binding"
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  
  subject {
    kind      = "Group"
    name      = var.admin_group
    api_group = "rbac.authorization.k8s.io"
  }
}

# Developer Role
resource "kubernetes_cluster_role" "developer" {
  metadata {
    name = "developer-role"
  }

  rule {
    api_groups = ["", "apps", "batch", "extensions"]
    resources  = ["deployments", "replicasets", "pods", "jobs", "services", "configmaps", "secrets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
  
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

# Developer Role binding
resource "kubernetes_cluster_role_binding" "developer" {
  metadata {
    name = "gke-developer-binding"
  }
  
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.developer.metadata[0].name
  }
  
  subject {
    kind      = "Group"
    name      = var.developer_group
    api_group = "rbac.authorization.k8s.io"
  }
}
