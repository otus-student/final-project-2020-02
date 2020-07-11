resource "google_compute_instance" "gitlab-ci-instance" {
  name         = "${var.env}-gitlab-ci-instance"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["${var.env}-gitlab-ci-instance"]
  labels = {
    environment = var.env_label
  }
  boot_disk {
    initialize_params {
      image = var.instance_disk_image
      size  = var.instance_size_gb
    }
  }
  network_interface {
    network = google_compute_network.env_subnet.name
    access_config {}
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_gitlab" {
  name    = "allow-web-access-default-${var.env}"
  network = google_compute_network.env_subnet.name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.env}-gitlab-ci-instance"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh-${var.env}"
  network = google_compute_network.env_subnet.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "env_subnet" {
  name = "${var.env}-network"
  auto_create_subnetworks = true
}
