# module "k0s-cluster" {
#   # source = "git::https://github.com/qtsone/terraform-k8s-vault.git?ref=v1.0.0"
#   source = "/Users/ibacalu/Seafile/Work/qts/github/qtsone/terraform-k8s-vault"

#   config = {
#     kubernetes_host = var.kubernetes_api_url
#     cluster_issuer  = "system:konnectivity-server"
#     auth_backend    = local.cluster_name
#     secret_backend  = var.vault.secret_backend
#     # bound_sa_names      = ["argocd-repo-server", "vault-auth"]
#     # bound_sa_namespaces = ["argocd", "kube-system"]
#     secret_backend_create = true
#   }
# }

locals {
  namespace     = "argocd"
  dns_zone_name = "${var.region}.${var.dns_root}"
  cluster_name  = "k0s-ber"

  configmaps = [
    {
      name      = "cluster-config"
      namespace = local.namespace
      data = {
        rootDNSZoneName     = "qts.one"
        clusterDNSZoneName  = local.dns_zone_name
        github_organisation = var.github.organisation
        address-pool        = "10.0.2.60-10.0.2.70"
        cluster-issuer      = "letsencrypt-prod"
        cluster_name        = local.cluster_name
        letsencrypt_email   = "ibacalu@icloud.com"
      }
    },
  ]

  org_secrets = {
    name      = "github-org-credentials"
    namespace = local.namespace
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
      "app.kubernetes.io/name"         = "github-org-credentials"
    }
    stringData = {
      type                    = "github"
      url                     = "${var.github.server_url}/${var.github.organisation}"
      organisation            = var.github.organisation
      clientSecret            = var.github.client_secret
      githubAppID             = var.github.application_id
      githubAppInstallationID = var.github.installation_id
      githubAppPrivateKey     = file(var.github.private_key_path)
    }
  }
  secrets = concat([local.org_secrets], var.secrets)
}

module "argocd" {
  source = "git::https://github.com/qtsone/terraform-k8s-argocd.git?ref=v1.0.0"
  # source = "/Users/ibacalu/Seafile/Work/qts/github/qtsone/terraform-k8s-argocd"

  config = {
    argocd_base_url = "https://github.com/qtsone/argo//services/argocd/base?ref=main"
    organisation = {
      name        = "qtsone"
      repo_url    = "https://github.com/qtsone/organisation.git"
      repo_path   = "."
      branch      = "main"
      environment = "development"
    }

    configmaps = local.configmaps
    secrets    = local.secrets
  }
}
