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
  project = google_project.default.project_id
  for_each = toset([
    "cloudasset.googleapis.com",
    "policytroubleshooter.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "bigquery.googleapis.com",
  ])
  service                    = each.value
  disable_dependent_services = true
}

data "google_client_openid_userinfo" "default" {
}

data "google_project" "default" {
  project_id = google_project.default.project_id
  depends_on = [
    google_project_service.project_service
  ]
}

########################################################################
# IAM
########################################################################

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "default_client" {
  for_each = toset([
    "roles/iam.serviceAccountTokenCreator",
    "roles/serviceusage.serviceUsageAdmin",
  ])
  project = google_project.default.id
  role    = each.value
  member  = "user:${data.google_client_openid_userinfo.default.email}"
}

resource "google_service_account" "defaulted" {
  account_id = "defaulted"
  depends_on = [data.google_project.default]
}

resource "google_service_account" "viewer" {
  account_id = "viewer"
  depends_on = [data.google_project.default]
}

resource "google_project_iam_member" "viewer_sa" {
  project = google_project.default.id
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
  depends_on = [data.google_project.default]
}

resource "google_storage_bucket_object" "object" {
  bucket  = google_storage_bucket.bucket.name
  name    = "data.ndjson"
  content = file("${path.module}/data.ndjson")
  depends_on = [data.google_project.default]
}

########################################################################
# BigQuery
########################################################################

resource "google_bigquery_dataset" "dataset_aaa" {
  dataset_id = "dataset_aaa"
  location   = var.google_region

  # https://cloud.google.com/bigquery/docs/dataset-access-controls
  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }
  access {
    role          = "WRITER"
    special_group = "projectWriters"
  }
  depends_on = [data.google_project.default]
}

resource "google_bigquery_table" "table_aaa" {
  dataset_id = google_bigquery_dataset.dataset_aaa.dataset_id
  table_id   = "table_aaa"

  deletion_protection = false

  schema = file("${path.module}/schema.json")
  depends_on = [data.google_project.default]
}

# resource "google_bigquery_job" "table_aaa" {
#   job_id = "table_aaa"
#   load {
#     source_uris = [
#       "gs://${google_storage_bucket_object.object.bucket}/${google_storage_bucket_object.object.name}"
#     ]
#     source_format = "NEWLINE_DELIMITED_JSON"

#     destination_table {
#       project_id = google_bigquery_table.table_aaa.project
#       dataset_id = google_bigquery_dataset.dataset_aaa.dataset_id
#       table_id   = google_bigquery_table.table_aaa.table_id
#     }

#     create_disposition = "CREATE_NEVER"
#     write_disposition  = "WRITE_TRUNCATE"
#   }
# }
