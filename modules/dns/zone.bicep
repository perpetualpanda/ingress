@description('name of the primary dns zone')
param dns_zone_primary_name string

@description('project tags')
param tags object

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' = {
  name: dns_zone_primary_name
  location: 'global'
  tags: tags
  properties: {
    zoneType: 'Public'
  }
}
