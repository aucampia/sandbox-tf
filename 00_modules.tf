

module "try_bucket_defaults" {
  source                 = "./try_bucket_defaults"
  google_project_id      = "try-buckdef-660n"
  google_region          = var.google_region
  google_zone            = var.google_zone
  google_billing_account = var.google_billing_account
}

module "try_bucket_safe" {
  source                 = "./try_bucket_safe"
  google_project_id      = "try-bucksaf-n6fm"
  google_region          = var.google_region
  google_zone            = var.google_zone
  google_billing_account = var.google_billing_account
}
