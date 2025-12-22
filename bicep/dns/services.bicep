param dns_zone_name string
param ttl int

var purpose = 'public-homelab-service'

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dnszones_primary_name_nas 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'nas'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    ARecords: [
      {
        ipv4Address: '140.82.45.8'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_status 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'status'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    ARecords: [
      {
        ipv4Address: '140.82.45.8'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}
