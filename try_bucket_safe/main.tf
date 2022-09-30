resource "google_project" "default" {
  name                = var.google_project_id
  project_id          = var.google_project_id
  billing_account     = var.google_billing_account
  auto_create_network = false
}

data "google_client_openid_userinfo" "default" {
}

data "google_project" "default" {
  project_id = google_project.default.project_id
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

resource "google_storage_bucket" "bucket" {
  name     = "${var.google_project_id}-bucket"
  location = var.google_region

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "object" {
  bucket  = google_storage_bucket.bucket.name
  name    = "object"
  content = <<-EOT
    sensitive content
  EOT
}

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "default_client" {
  for_each = toset([
    "roles/iam.serviceAccountTokenCreator",
  ])
  project = data.google_project.default.id
  role    = each.value
  member  = "user:${data.google_client_openid_userinfo.default.email}"
}


# resource "google_project_iam_binding" "project" {
#   project = data.google_project.default.id
#   role    = "roles/storage.legacyBucketReader"
#   members = []
# }

resource "google_storage_bucket_iam_binding" "project" {
  bucket = google_storage_bucket.bucket.name
  role    = "roles/storage.legacyBucketReader"
  members = []
}
