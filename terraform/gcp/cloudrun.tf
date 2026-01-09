resource "google_cloud_run_v2_service" "backend" {
  name     = "devops-backend-v4"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      min_instance_count = 2
    }
    containers {
      image = "gcr.io/${var.project_id}/devops-backend:latest"
      ports {
        container_port = 8000
      }
      env {
        name = "ALLOWED_ORIGINS"
        value = "*"
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "backend_public" {
  name = google_cloud_run_v2_service.backend.name
  location = var.region
  role = "roles/run.invoker"
  member = "allUsers"
}

resource "google_cloud_run_v2_service" "frontend" {
  name     = "devops-frontend-v4"
  location = var.region
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "gcr.io/${var.project_id}/devops-frontend:latest"
      ports {
        container_port = 3000
      }
      env {
        name  = "NEXT_PUBLIC_API_URL"
        value = "${google_cloud_run_v2_service.backend.uri}"
      }
    }
  }
  
  depends_on = [google_cloud_run_v2_service.backend]
}

resource "google_cloud_run_v2_service_iam_member" "frontend_public" {
  name = google_cloud_run_v2_service.frontend.name
  location = var.region
  role = "roles/run.invoker"
  member = "allUsers"
}

output "frontend_url" {
  value = google_cloud_run_v2_service.frontend.uri
}

output "backend_url" {
  value = google_cloud_run_v2_service.backend.uri
}
