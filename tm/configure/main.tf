locals {
  namespace     = "argocd"
  dns_zone_name = "${var.region}.${var.dns_root}"
  cluster_name  = "k0s-tm"

  configmaps = [
    {
      name      = "cluster-config"
      namespace = local.namespace
      data = {
        rootDNSZoneName     = "qts.one"
        clusterDNSZoneName  = local.dns_zone_name
        github_organisation = var.github.organisation
        address-pool        = "10.10.1.50-10.10.1.60"
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
