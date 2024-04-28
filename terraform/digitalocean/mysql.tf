resource "digitalocean_database_cluster" "mysql_server" {
  name       = "${var.application}-db"
  engine     = "mysql"
  version    = "8"
  size       = var.mysql_size
  region     = var.do_region
  node_count = 1
}

resource "digitalocean_database_mysql_config" "mysql_config" {
  cluster_id              = digitalocean_database_cluster.mysql_server.id
  sql_require_primary_key = false
}

resource "digitalocean_database_user" "mysql_user" {
  cluster_id = digitalocean_database_cluster.mysql_server.id
  name       = var.mysql_user
}
