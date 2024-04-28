# Set the variable values in *.tfvars file
# or using CLI option e.g., -var="application=..."
variable "application" {
    default = "larable"
}

variable "gcp_credentials" {}

variable "gcp_project" {}

variable "gcp_region" {
    default = "asia-south1"
}

variable "gcp_zone" {
    default = "asia-south1-a"
}

variable "mysql_tier" {
    default = "db-n1-standard-2"
}

variable "mysql_user" {
    default = "larable"
}

variable "redis_memory_size_in_gb" {
    default = 1
}

variable "redis_tier" {
    default = "BASIC"
}

variable "server_disk_size_in_gb" {
    default = 50
}

variable "server_image" {
    default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "server_type" {
    default = "n2-standard-2"
}
