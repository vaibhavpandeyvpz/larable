# Create "server" instance
resource "google_compute_address" "server_ip" {
  name = "${var.application}-ipv4"
}

resource "google_compute_instance" "server" {
  name         = "${var.application}-server"
  machine_type = var.server_type

  boot_disk {
    initialize_params {
      image = var.server_image
      size  = var.server_disk_size_in_gb
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.server_ip.address
    }
  }
}
