param resource_group_name   string = 'rg-dns-pub-westus'
param dns_primary_zone_name string = 'ppanda.org'

module dnsModule './dns.bicep' = {
  name: 'dnsDeployment'
  scope: resourceGroup(resource_group_name)
  params: {
    dnszones_primary_name: dns_primary_zone_name
  }
}
