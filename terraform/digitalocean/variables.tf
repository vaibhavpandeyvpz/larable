# Set the variable values in *.tfvars file
# or using CLI option e.g., -var="application=..."
variable "application" {
    default = "larable"
}

variable "do_region" {
    default = "blr1"
}

variable "do_spaces_access_id" {}

variable "do_spaces_secret_key" {}

variable "do_token" {}

variable "mysql_size" {
    default = "db-s-1vcpu-1gb"
}

variable "mysql_user" {
    default = "larable"
}

variable "redis_size" {
    default = "db-s-1vcpu-1gb"
}

variable "server_image" {
    default = "ubuntu-22-04-x64"
}

variable "server_size" {
    default = "s-1vcpu-2gb"
}
