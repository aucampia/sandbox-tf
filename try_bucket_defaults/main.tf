########################################################################
# Project
########################################################################

resource "google_project" "default" {
  name                = var.google_project_id
  project_id          = var.google_project_id
  billing_account     = var.google_billing_account
  auto_create_network = false
}

resource "google_project_iam_audit_config" "default" {
  project = google_project.default.project_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_service" "project_service" {
  for_each = toset([
    "cloudasset.googleapis.com",
    "policytroubleshooter.googleapis.com",
  ])
  service                    = each.value
  disable_dependent_services = true
}

data "google_client_openid_userinfo" "default" {
}

data "google_project" "default" {
  project_id = google_project.default.project_id
}

########################################################################
# IAM
########################################################################

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "default_client" {
  for_each = toset([
    "roles/iam.serviceAccountTokenCreator",
  ])
  project = data.google_project.default.id
  role    = each.value
  member  = "user:${data.google_client_openid_userinfo.default.email}"
}

resource "google_service_account" "defaulted" {
  account_id = "defaulted"
}

resource "google_service_account" "viewer" {
  account_id = "viewer"
}

resource "google_project_iam_member" "viewer_sa" {
  project = data.google_project.default.id
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.viewer.email}"
}

########################################################################
# Buckets
########################################################################

resource "google_storage_bucket" "bucket" {
  name     = "${var.google_project_id}-bucket"
  location = var.google_region

  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  bucket  = google_storage_bucket.bucket.name
  name    = "object"
  content = <<-EOT
    sensitive content
  EOT
}
