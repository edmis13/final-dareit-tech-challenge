resource "google_compute_instance" "dareit-vm-ci-fin" {
  name         = "dareit-vm-tf-ci-fin"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  tags         = ["tech"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "static" {
  project                     = "western-cascade-378410"
  name                        = "edm-dareit-static-final"
  location                    = "US"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "member" {
  provider = google-beta
  bucket   = "edm-dareit-static-final"
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}

resource "google_storage_bucket_object" "default" {
  name   = "index.html"
  source = "website/index.html"
  bucket = "edm-dareit-static-final"
}