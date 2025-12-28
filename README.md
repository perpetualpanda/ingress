# Ingress - ppanda.org

Infrastructure as code for homelab ingress Azure deployments

## GitHub Actions Authentication

Service principal is created at subscription-level scope for bootstrapping
Azure resources. Authentication is set up via a federated identity credential.

Creating the initial service principal:

```
az ad sp create-for-rbac \
    --name spn-gh-actions-vm \
    --role Contributor \
    --scopes /subscriptions/<SUBCRIPTION_ID>
```

- [Azure Login OIDC Docs](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect)
- [Service Principal (spn-gh-actions-deploy)](https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Overview/objectId/efc8dd45-b094-4d96-bc95-cc56d49e6b20/appId/26532c64-b438-4b0f-85b4-8d6e9ffea5f4)
