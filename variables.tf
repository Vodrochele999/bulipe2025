variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1" # Default region
}

variable "zone" {
  type        = string
  description = "GCP zone"
  default     = "us-central1-a" # Default zone
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "my-gke-cluster"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the GKE cluster"
  default     = 3
}

variable "machine_type" {
  type        = string
  description = "Machine type for the GKE nodes"
  default     = "e2-medium"
}

variable "container_image" {
  type        = string
  description = "Docker image to deploy"
  # Example: gcr.io/YOUR_PROJECT_ID/my-web-app:latest
}

variable "container_port" {
  type        = number
  description = "Port the container is listening on"
  default     = 80
}

variable "replica_count" {
  type = number
  description = "Number of replicas (pods) for the deployment"
  default = 3
}

variable "app_name" {
  type = string
  description = "Name of the application"
  default = "my-web-app"
}
