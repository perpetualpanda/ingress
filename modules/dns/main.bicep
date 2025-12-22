param dns_primary_zone_name string
param tags                  object

module dns './dns.bicep' = {
  name: 'dns_deployment'
  params: {
    dnszones_primary_name: dns_primary_zone_name
    tags: tags
  }
}
