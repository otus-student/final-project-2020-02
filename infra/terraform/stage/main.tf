terraform {
  required_version = ">= 0.12"
}

provider "google" {
  version = "~>2.5.0"
  project = var.project
  region  = var.region
}

module gitlab-ci-instance {
  source          = "../modules/gitlab-ci-instance"
  zone            = var.zone
  env             = var.env
  public_key_path = var.public_key_path
  env_label       = var.env_label
}
