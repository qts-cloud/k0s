# Bootstrap Cluster


## Requirements

### Secrets

```hcl
locals {
  secret_backend = "argo"
  secrets = {
    "${local.secret_backend}/service/argocd/dex" = {
      clientID     = "redacted"
      clientSecret = "redacted"
    }
    "${local.secret_backend}/service/argo-workflows/sso" = {
      clientID     = "redacted"
      clientSecret = "redacted"
    }
    "${local.secret_backend}/service/argo-workflows/github-access" = {
      secret                  = "redacted"
      githubAppID             = <redacted>
      githubAppInstallationID = <redacted>
      githubAppPrivateKey     = file("../../private-key.pem")
      githubURL               = "redacted"
    }
    "${local.secret_backend}/service/argo-workflows/notifications" = {
      slackToken = "redacted"
    }
    "${local.secret_backend}/service/cert-manager/prod" = {
      email = "redacted"
      token = "redacted"
    }
    "${local.secret_backend}/service/cert-manager/staging" = {
      email = "redacted"
      token = "redacted"
    }
    "${local.secret_backend}/service/external-dns/cloudflare" = {
      token = "redacted"
    }
    "${local.secret_backend}/service/cloudflared/tunnel" = {
      token = "redacted"
    }
    # TODO: REMOVE THIS
    "${local.secret_backend}/service/grafana/admin" = {
      user = "redacted"
      password = "redacted"
    }
    "${local.secret_backend}/service/grafana/credentials" = {
      user = "redacted"
      password = "redacted"
    }
    "${local.secret_backend}/service/openwebui/openai" = {
      api_keys = "redacted"
      rag_api_key = "redacted"
    }
    "${local.secret_backend}/service/searxng/config" = {
      secret_key = "redacted"
    }
    "${local.secret_backend}/service/postgresql/credentials" = {
      adminPassword = "redacted"
      userPassword = "redacted"
      replicationPassword = "redacted"
    }
    "${local.secret_backend}/service/influxdb/credentials" = {
      adminPassword = "redacted"
      adminToken = "redacted"
    }
  }
}
```
