param dns_zone_primary_name string
param tags                  object

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' = {
  name: dns_zone_primary_name
  location: 'global'
  tags: tags
  properties: {
    zoneType: 'Public'
  }
}
