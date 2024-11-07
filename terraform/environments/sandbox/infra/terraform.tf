terraform {
  required_version = "~> 1.6.0"
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
#   backend "gcs" {
#     bucket = "project-35-postgres-tfstate-bucket"
#     prefix = "terraform/state/sandbox/infra"
#   }
}