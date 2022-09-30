resource "google_project" "default" {
  name       = var.google_project_id
  project_id = var.google_project_id
}

data "google_project" "default" {
  project_id = google_project.default.project_id
}

