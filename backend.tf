terraform {
  required_version = ">= 1.0.11"
  backend "gcs" {
    bucket = "8b6234dde8e56010-bucket-tfstate"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.41.0"
    }
  }
}