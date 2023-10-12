resource "google_compute_instance" "terraform" {
  project      = "khalid-gcp-00-4bbxd0ol0m"
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "us-central1"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}