resource "google_storage_bucket" "storage_bucket" {
  name                     = "${var.application}-files"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}

resource "google_service_account" "storage_service_account" {
  account_id = "${var.application}-files"
}

resource "google_storage_bucket_iam_binding" "storage_bucket_binding" {
  bucket = google_storage_bucket.storage_bucket.name
  role   = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${google_service_account.storage_service_account.email}"
  ]
}

resource "google_storage_hmac_key" "storage_service_account_key" {
  service_account_email = google_service_account.storage_service_account.email
}
