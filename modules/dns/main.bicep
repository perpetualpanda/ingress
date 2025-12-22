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
  params: {
    dnszones_primary_name: dns_primary_zone_name
    tags: tags
  }
}
