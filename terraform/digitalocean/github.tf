/**
 * # Github Repository
 *
 * The Terraform configuration need to update Github Action Variable 
 * This way we can manage secret and inventory automatically
 */

data "github_repository" "repo" {
  full_name = var.repo_name
}

data "github_user" "deployement_approver" {
  username = var.deployement_approver
}

resource "github_repository_environment" "digitalocean_environment" {
  repository       = data.github_repository.repo.name
  environment      = "digitalocean"
  reviewers {
    users = [data.github_user.deployement_approver.id]
    # teams = [] an entire team can be approver
  }

  deployment_branch_policy {
    protected_branches     = true #the main branch protection definition is below
    custom_branch_policies = false
  }

}

/**
 * Github branch permissions
 *
 */

resource "github_branch_protection_v3" "main" {
  repository     = data.github_repository.repo.name
  branch         = "main"
  # enforce_admins = true 

  # Configure the check api
  required_status_checks {
    strict   = false
    contexts = ["validate"]
  }
}

/**
 * Github environnement secretes
 *
 */

resource "github_actions_environment_secret" "test_secret" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.digitalocean_environment.environment
  secret_name      = "test_secret_name"
  plaintext_value  = "%s"
}

resource "github_actions_environment_secret" "inventory" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.digitalocean_environment.environment
  secret_name      = "inventory"
  plaintext_value  = templatefile(
    "${path.module}/templates/ansible_inventory.tpl",
    { 
      nodes = digitalocean_droplet.node.*.ipv4_address,
      managers = digitalocean_droplet.node.*.ipv4_address
    }
  )
}

resource "github_actions_environment_secret" "ssh" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.digitalocean_environment.environment
  secret_name      = "ssh_key"
  plaintext_value  = tls_private_key.ssh.private_key_pem
}

data "sshclient_host" "host" {
  for_each = { for node in digitalocean_droplet.node : node.ipv4_address => node }
  hostname = each.key
  username = "keyscan"
  insecure_ignore_host_key = true # we use this to scan and obtain the key
}
data "sshclient_keyscan" "keyscan" {
  for_each  = data.sshclient_host.host
  host_json = each.value.json
}
resource "github_actions_environment_secret" "known_hosts" {
  repository       = data.github_repository.repo.name
  environment      = github_repository_environment.digitalocean_environment.environment
  secret_name      = "known_hosts"
  plaintext_value  = templatefile(
    "${path.module}/templates/known_hosts.tpl",
    { 
      keyscan = data.sshclient_keyscan.keyscan,
    }
  )
}
