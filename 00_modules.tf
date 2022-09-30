

module "try_bucket_defaults" {
  source                 = "./try_bucket_defaults"
  google_project_id      = "try-buckdef-660n"
  google_region          = var.google_region
  google_zone            = var.google_zone
  google_billing_account = var.google_billing_account
}


# module "sappmr_profile_data" {
#   source = "./sappmr-profile-data"
#   gcn_project_id = var.project_id
#   gcn_network_name = data.google_compute_network.coop.name
#   gcn_subnet_name = data.google_compute_subnetwork.project.name
# }

# module "cloud_build_rclone" {
#   source = "./cb_rclone"

# }
