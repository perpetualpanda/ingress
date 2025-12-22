# Ingress - ppanda.org

Infrastructure as code for homelab ingress Azure deployments

## Secret rotation

Update the `AZURE_CREDENTIALS` secret with the format:

```
{
  "clientId": "<CLIENT_ID>",
  "clientSecret": "<CLIENT_SECRET>",
  "subscriptionId": "<SUBSCRIPTION_ID>",
  "tenantId": "<TENANT_ID>"
}
```

## Bootstrap Secret

Service principal at subscription-level scope for bootstrapping azure resources

- [GitHub Actions secret](https://github.com/perpetualpanda/dns/settings/secrets/actions/AZURE_CREDENTIALS_BOOTSTRAP)
- [Service Principal (spn-gh-actions-bootstrap)](https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Overview/objectId/288b577e-7e6d-49d7-9c67-ea99e13549f1/appId/5b0f4d34-00d0-472d-8fb9-b72eea4c547e)
