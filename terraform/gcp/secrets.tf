resource "google_secret_manager_secret" "app_secret" {
  secret_id = "devops-app-secret-v4"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "app_secret_val" {
  secret = google_secret_manager_secret.app_secret.id
  secret_data = var.database_secret
}

# Grant access to Cloud Run service account (default compute SA for simplicity, or creating a new one is better)
# For this assignment, we will assume default compute service account for Cloud Run
data "google_compute_default_service_account" "default" {
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  secret_id = google_secret_manager_secret.app_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${data.google_compute_default_service_account.default.email}"
}
