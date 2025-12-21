# DNS - ppanda.org

IaC for DNS configurations

## Secret rotation

Update the `AZURE_CREDENTIALS` secret:

```
{
  "clientId": "<CLIENT_ID>",
  "clientSecret": "<CLIENT_SECRET>",
  "subscriptionId": "<SUBSCRIPTION_ID>",
  "tenantId": "<TENANT_ID>"
}
```

- [GitHub Actions secret](https://github.com/perpetualpanda/dns/settings/secrets/actions/AZURE_CREDENTIALS)
- [SPN (spn-gh-actions-sub)](https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Overview/objectId/4046afc6-0c57-4c7b-b402-cdab956bdb44/appId/e9770942-ee53-4475-bd09-f9e5bf775be3)
