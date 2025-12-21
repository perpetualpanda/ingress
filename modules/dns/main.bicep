@description('Name of the resource group to deploy the dns zone into')
param resource_group_name   string = 'rg-dns-pub-westus'

@description('Name of the primary dns zone to deploy')
param dns_primary_zone_name string = 'ppanda.org'

@description('Metadata tags for the project')
param tags object = {
  deployment_type: 'automated'
  environment: 'public'
  project: 'homelab'
  purpose: 'public-ingress'
}

module dnsModule './dns.bicep' = {
  name: 'dnsDeployment'
  scope: resourceGroup(resource_group_name)
  tags: tags
  params: {
    dnszones_primary_name: dns_primary_zone_name
  }
}
