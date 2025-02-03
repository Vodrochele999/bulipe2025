# Configure the Google Cloud Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # Or specify a specific version
    }
  }
}

provider "google" {
  project = "bulipe2025" # Replace with your GCP project ID
  region  = "us-central1" # Replace with your desired region
}

# Create a GKE cluster
resource "google_container_cluster" "primary" {
  name               = "my-gke-cluster"
  location           = "us-central1-a" # Replace with your desired zone
  initial_node_count = 3

  node_pool {
    name           = "default-pool"
    machine_type = "e2-medium" # Adjust machine type as needed
  }
}

# Define the Kubernetes deployment
resource "kubernetes_deployment" "web_app" {
  metadata {
    name = "my-web-app-deployment"
    labels = {
      app = "my-web-app"
    }
  }
  spec {
    replicas = 3 # Number of pods
    selector {
      match_labels = {
        app = "my-web-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "my-web-app"
        }
      }
      spec {
        container {
          name  = "my-web-app-container"
          image = "gcr.io/YOUR_PROJECT_ID/my-web-app:latest" # Replace with your image
          ports {
            container_port = 80 # Port your app listens on
          }
        }
      }
    }
  }

}


# Define the Kubernetes service to expose the deployment
resource "kubernetes_service" "web_app" {
  metadata {
    name = "my-web-app-service"
    labels = {
      app = "my-web-app"
    }
  }
  spec {
    selector = {
      app = "my-web-app"
    }
    ports {
      port        = 80 # Port exposed by the service
      target_port = 80 # Port the container listens on
    }
    type = "LoadBalancer" # Expose the service externally
  }
  depends_on = [
    kubernetes_deployment.web_app
  ]
}

# Output the Load Balancer IP
output "load_balancer_ip" {
  value = kubernetes_service.web_app.status.load_balancer_ingress[0].ip
  description = "IP address of the Load Balancer"
}
