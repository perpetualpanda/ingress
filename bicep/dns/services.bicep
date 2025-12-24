param dns_zone_name string
param ttl int

var purpose = 'public-homelab-service'

resource dns_zone_resource 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dns_zone_a_nas_resource 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone_resource
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

resource dns_zone_a_status_resource 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone_resource
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
