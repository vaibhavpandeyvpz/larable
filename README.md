# larable

[Terraform](https://www.terraform.io/) modules and [Ansible](https://www.ansible.com/) scripts to orchestrate setup, deployment (and redeployment) of a [Laravel](https://laravel.com/) project for flat deployments because not every developer is a DevOps expert but clients still expect them to be. 🥲
Using these scripts, you can even deploy multiple [Laravel](https://laravel.com/) projects on the same server, if desired.

This project contains [Terraform](https://www.terraform.io/) modules for [DigitalOcean](https://www.digitalocean.com/) and [Google Cloud Platform](https://console.cloud.google.com/).
Depending on your cloud platform on your choice, you can use either of those available providers.

## Prepare

Firstly, make sure you have [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/) installed on your workstation.

### DigitalOcean

If you plan to use [DigitalOcean](https://www.digitalocean.com/) providers, go to [this page](https://cloud.digitalocean.com/account/api/tokens) and create a Personal Access Token.
In addition, go to [this page](https://cloud.digitalocean.com/account/api/spaces) and create a Spaces Access Key as well.

To access the droplet via SSH for running [Ansible](https://www.ansible.com/) scripts, go to [this page](https://cloud.digitalocean.com/account/security) and add your public SSH key.

### Google Cloud Platform

To use [Google Cloud Platform](https://console.cloud.google.com/), select the relevant project and enable access to following APIs:

- [cloudresourcemanager.googleapis.com](https://console.cloud.google.com/apis/library/cloudresourcemanager.googleapis.com)
- [compute.googleapis.com](https://console.cloud.google.com/apis/library/compute.googleapis.com)
- [dns.googleapis.com](https://console.cloud.google.com/apis/library/dns.googleapis.com)
- [redis.googleapis.com](https://console.cloud.google.com/apis/library/redis.googleapis.com)
- [sqladmin.googleapis.com](https://console.cloud.google.com/apis/library/sqladmin.googleapis.com)

Go to [this page](https://console.cloud.google.com/iam-admin/serviceaccounts) and create a Service Account with `Basic > Owner` access.
Once created, also create a JSON key for newly created Service Account and save it in project folder.

To access the compute instance via SSH for running [Ansible](https://www.ansible.com/) scripts, go to [this page](https://console.cloud.google.com/compute/metadata?resourceTab=sshkeys) and add your public SSH key.

## Deployment

Begin with installing required [Terraform](https://www.terraform.io/) providers:

```shell
# For DigitalOcean
terraform -chdir=terraform/digitalocean init

# For Google Cloud Platform
terraform -chdir=terraform/google-cloud init
```

Once downloaded, deploy the resources using below commands:

```shell
# For DigitalOcean
terraform -chdir=terraform/digitalocean apply \
   -var="do_token=<digitalocean_pat>" \
   -var="do_spaces_access_id=<digitalocean_spaces_key_id>" \
   -var="do_spaces_secret_key=<digitalocean_spaces_secret_key>"

# For Google Cloud Platform
terraform -chdir=terraform/google-cloud apply \
   -var="gcp_project=<gcp_project_id>" \
   -var="gcp_credentials=$(pwd)/<service_account_key_file>.json"
```

Once resources are up, you can now set up required server software e.g., [PHP](https://www.php.net/) etc.

```shell
ansible-playbook -i inventory.ini -u root ansible/setup.yml
```

You may want to copy the public SSH key from the output of above command and add to your Git repository's Access Keys for read-only access.

Make a copy of `sites/example.yml` and update your site specific values.

```shell
# copy example site config
cp sites/example.yml sites/yoursite.yml

# update values in sites/yoursite.yml
```

Before deploying, if you point your configured domain in `sites/yoursite.yml` to your newly created server's IP address, the deployment scripts can also take care of installing a free [Let's Encrypt](https://letsencrypt.org/) SSL certificate automatically.

Finally, deploy your site to newly created server:

```shell
ansible-playbook -i inventory.ini -u root ansible/deploy.yml --extra-vars "@sites/yoursite.yml"
```

In the future, if you ever wish to update your site with latest changes, you can run below command to automatically pull latest changes from your Git repository:

```shell
ansible-playbook -i inventory.ini -u root ansible/redeploy.yml --extra-vars "@sites/yoursite.yml"
```

Send your love ♥️ by starring the repository.
