# Ingress - ppanda.org

Infrastructure as code for homelab ingress Azure deployments

## Authentication

Service principal is created at subscription-level scope for bootstrapping
Azure resources. Authentication is set up via a federated identity credential.

- [Service Principal (spn-gh-actions-deploy)](https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Overview/objectId/288b577e-7e6d-49d7-9c67-ea99e13549f1/appId/5b0f4d34-00d0-472d-8fb9-b72eea4c547e)
- [Azure Login OIDC Docs](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect)
