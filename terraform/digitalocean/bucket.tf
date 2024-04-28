resource "digitalocean_spaces_bucket" "storage_bucket" {
  name   = "${var.application}-files"
  region = var.do_region
}
