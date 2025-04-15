# Terraform GCP Infrastructure

This repository contains a modular Terraform configuration for deploying a comprehensive Google Cloud Platform (GCP) infrastructure. The configuration creates a secure, scalable environment for running containerized applications.

## Key Components

### API Enablement
- Automatically enables required GCP APIs
- Uses the terraform-google-modules/project-factory module
- Ensures all necessary services are available before resource creation

### GKE Cluster with Standard Configuration
- Creates a regional GKE cluster with node pools spread across multiple zones
- Enables Workload Identity for secure pod authentication
- Configures private cluster options for enhanced security
- Sets up VPC-native networking with IP allocation policies

### Secret Manager Integration
- Creates a Secret Manager secret for the PostgreSQL password
- Generates a random secure password
- Grants the GKE service account permission to access the secret using roles/secretmanager.secretAccessor

### Cloud SQL PostgreSQL Instance
- Provisions a PostgreSQL 14 instance
- Configures backup and maintenance windows
- Sets up private network access for security
- Creates a database and user with the password stored in Secret Manager

### RBAC Configuration
- Creates a Kubernetes admin role bound to a Google Group for full cluster administration
- Creates a developer role with permissions to deploy applications and create load balancers
- Binds roles to Google Groups for easy user management

## Modular Structure

The project is organized into the following modules:

```
simples-tf-app/
├── main.tf                 # Main configuration calling modules
├── variables.tf            # Root-level variables
├── outputs.tf              # Root-level outputs
├── terraform.tfvars        # Variable values
├── versions.tf             # Terraform and provider versions
├── modules/
│   ├── networking/         # VPC and subnet configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── gke/                # GKE cluster configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sql/                # Cloud SQL configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── secret/             # Secret Manager configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── rbac/               # RBAC configuration
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── memory-bank/            # Documentation
```

## Module Dependencies

```
Root
  │
  ├─► Project Services
  │      │
  │      ▼
  ├─► Networking
  │      │
  │      ▼
  ├─► GKE ─────┐
  │             │
  ├─► Secret ◄──┤
  │      │      │
  │      ▼      │
  └─► SQL       │
         │      │
         ▼      │
        RBAC ◄──┘
```

## Prerequisites

1. **Terraform CLI** (version 1.0.0 or higher)
2. **Google Cloud SDK** installed and configured
3. **kubectl** for Kubernetes interaction
4. GCP project with billing enabled
5. Appropriate IAM permissions to create resources

## Setup

### 1. Install Required Tools

```bash
# Install Terraform (MacOS)
brew install terraform

# Install Terraform (Linux)
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Install Google Cloud SDK
# Follow instructions at https://cloud.google.com/sdk/docs/install
```

### 2. Configure Google Cloud SDK

```bash
# Initialize gcloud
gcloud init

# Authenticate application default credentials
gcloud auth application-default login
```

## Usage

### 1. Customize Variables

Edit `terraform.tfvars` to customize the deployment:

```hcl
project_id      = "your-project-id"
region          = "your-preferred-region"
vpc_name        = "custom-vpc-name"
subnet_name     = "custom-subnet-name"
cluster_name    = "custom-cluster-name"
admin_group     = "your-admin-group@example.com"
developer_group = "your-developer-group@example.com"
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Plan the Deployment

```bash
terraform plan -var-file=terraform.tfvars
```

### 4. Apply the Configuration

```bash
terraform apply -var-file=terraform.tfvars
```

### 5. Access the GKE Cluster

```bash
gcloud container clusters get-credentials primary-cluster --region us-central1 --project your-project-id
```

## Outputs

After successful deployment, Terraform will output:

- Kubernetes cluster name and endpoint
- Cloud SQL instance name and connection name
- Secret Manager secret name
- VPC network name
- RBAC role and binding names

## Security Considerations

This configuration implements several security best practices:

- Private GKE cluster with no public node IPs
- Workload Identity for secure pod authentication
- Private connectivity for Cloud SQL
- Secret Manager for sensitive data
- RBAC for access control
- Least privilege IAM permissions

## Cleanup

To destroy all resources created by this configuration:

```bash
terraform destroy -var-file=terraform.tfvars
```

**Warning**: This will permanently delete all resources. Use with caution.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
