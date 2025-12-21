# DNS IaC - ppanda.org

Infrastructure as code for Azure DNS deployment

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
- [Service Principal (spn-gh-actions-dns)](https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Overview/objectId/845c7e99-e39f-49f2-aaa0-ae0976ff8097/appId/a76aa987-4129-4b7e-9edd-6c2393f59da2)
