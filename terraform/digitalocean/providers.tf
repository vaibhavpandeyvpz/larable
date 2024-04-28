terraform {
    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "~> 2.0"
        }
    }
}

provider "digitalocean" {
    token             = var.do_token
    spaces_access_id  = var.do_spaces_access_id
    spaces_secret_key = var.do_spaces_secret_key
}
