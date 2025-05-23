terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0.0"
    }
    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}
