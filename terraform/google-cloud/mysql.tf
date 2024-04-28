resource "google_sql_database_instance" "mysql_server" {
  name             = "${var.application}-db"
  database_version = "MYSQL_8_0"

  settings {
    tier = var.mysql_tier

    database_flags {
      name  = "sql_require_primary_key"
      value = "off"
    }

    ip_configuration {
      authorized_networks {
        name  = google_compute_instance.server.name
        value = google_compute_instance.server.network_interface.0.access_config.0.nat_ip
      }
    }
  }
}

resource "random_password" "mysql_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_user" "mysql_user" {
  instance = google_sql_database_instance.mysql_server.name
  name     = var.mysql_user
  host     = "%"
  password = random_password.mysql_password.result
}
