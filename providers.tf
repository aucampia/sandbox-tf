

provider "null" {
}

provider "random" {
}

provider "google-beta" {
  project = var.google_project_id
  region  = var.google_region
  zone    = var.google_zone
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
provider "google" {
  project = var.google_project_id
  region  = var.google_region
  zone    = var.google_zone
}

provider "github" {
  # Configuration options
  owner = "iasandbox"
}
