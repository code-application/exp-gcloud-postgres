# ===============================
# Common
# ===============================
variable "project_id" {
  description = "GCP project ID"
  type        = string
  sensitive   = true
}

variable "credentials_file" {
  description = "A credential file path of Service Account for Terraform"
  type        = string
  sensitive   = true
}

variable "region" {
  default     = "asia-northeast1"
  description = "GCP region"
  type        = string
}

variable "zone" {
  default     = "asia-northeast1-a"
  description = "GCP availability zone"
  type        = string
}