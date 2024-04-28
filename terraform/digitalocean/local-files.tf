resource "local_file" "ansible_inventory" {
  content = templatefile("../templates/inventory.tmpl", {
    server = { ipv4 : digitalocean_reserved_ip.server_ip.ip_address },
  })
  filename = "../../inventory.ini"
}

resource "local_file" "ansible_outputs" {
  content = templatefile("../templates/outputs.tmpl", {
    db = {
      host     = digitalocean_database_cluster.mysql_server.private_host
      port     = digitalocean_database_cluster.mysql_server.port
      user     = digitalocean_database_user.mysql_user.name
      password = digitalocean_database_user.mysql_user.password
    }
    redis = {
      host     = "tls://${digitalocean_database_cluster.redis_server.private_host}"
      port     = digitalocean_database_cluster.redis_server.port
      password = digitalocean_database_cluster.redis_server.password
    }
    s3 = {
      endpoint          = "https://${digitalocean_spaces_bucket.storage_bucket.endpoint}"
      access_key_id     = var.do_spaces_access_id
      secret_access_key = var.do_spaces_secret_key
      bucket            = digitalocean_spaces_bucket.storage_bucket.name
      region            = digitalocean_spaces_bucket.storage_bucket.region
    }
  })
  filename = "../../outputs.yml"
}
