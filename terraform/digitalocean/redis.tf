resource "digitalocean_database_cluster" "redis_server" {
  name       = "${var.application}-mdb"
  engine     = "redis"
  version    = "7"
  size       = var.redis_size
  region     = var.do_region
  node_count = 1
}

resource "digitalocean_database_redis_config" "redis_config" {
  cluster_id       = digitalocean_database_cluster.redis_server.id
  maxmemory_policy = "allkeys-lru"
  ssl              = true
}
