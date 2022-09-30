# locals {
#   try_bucket = {
#     google_project_id = "try-bucket-dsc3"
#   }
# }

# resource "google_project" "try_bucket" {
#   name       = local.try_bucket.google_project_id
#   project_id = local.try_bucket.google_project_id
# }

# data "google_project" "try_bucket" {
#   project_id = google_project.try_bucket.project_id
# }

# resource "google_service_account" "defaulted" {
#   project_id = google_project.try_bucket.project_id
#   account_id = "defaulted"
# }

# resource "google_service_account" "viewer" {
#   project_id = google_project.try_bucket.project_id
#   account_id = "viewer"
# }


