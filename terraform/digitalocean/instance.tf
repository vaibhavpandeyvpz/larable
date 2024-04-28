resource "digitalocean_droplet" "server" {
  image    = var.server_image
  name     = "${var.application}-server"
  region   = var.do_region
  size     = var.server_size
  ipv6     = true
  ssh_keys = data.digitalocean_ssh_keys.keys.ssh_keys[*].id
}

resource "digitalocean_reserved_ip" "server_ip" {
  droplet_id = digitalocean_droplet.server.id
  region     = var.do_region
}

resource "digitalocean_database_firewall" "mysql_firewall" {
  cluster_id = digitalocean_database_cluster.mysql_server.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.server.id
  }
}

resource "digitalocean_database_firewall" "redis_firewall" {
  cluster_id = digitalocean_database_cluster.redis_server.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.server.id
  }
}
