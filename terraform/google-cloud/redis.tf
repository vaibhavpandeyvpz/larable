resource "google_redis_instance" "redis_server" {
  name           = "${var.application}-redis"
  auth_enabled   = true
  memory_size_gb = var.redis_memory_size_in_gb
  redis_configs  = {
    maxmemory-policy = "allkeys-lru"
  }
  redis_version = "REDIS_4_0"
  tier          = var.redis_tier
}
