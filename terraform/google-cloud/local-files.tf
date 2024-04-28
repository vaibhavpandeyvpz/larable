resource "local_file" "ansible_inventory" {
  content = templatefile("../templates/inventory.tmpl", {
    server = { ipv4 : google_compute_instance.server.network_interface[0].access_config[0].nat_ip },
  })
  filename = "../../inventory.ini"
}

resource "local_file" "ansible_outputs" {
  content = templatefile("../templates/outputs.tmpl", {
    db = {
      host     = google_sql_database_instance.mysql_server.public_ip_address
      port     = 3306
      user     = google_sql_user.mysql_user.name
      password = google_sql_user.mysql_user.password
    }
    redis = {
      host     = google_redis_instance.redis_server.host
      port     = google_redis_instance.redis_server.port
      password = google_redis_instance.redis_server.auth_string
    }
    s3 = {
      endpoint          = "https://storage.googleapis.com"
      access_key_id     = google_storage_hmac_key.storage_service_account_key.access_id
      secret_access_key = google_storage_hmac_key.storage_service_account_key.secret
      bucket            = google_storage_bucket.storage_bucket.name
      region            = var.gcp_region
    }
  })
  filename = "../../outputs.yml"
}
