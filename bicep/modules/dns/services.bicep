@description('name of the dns zone resource')
param dns_zone_name string

@description('public ip of the edge vm')
param edge_vm_public_ip string

@description('ttl for the dns records')
param ttl int

var purpose = 'public-homelab-service'

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dns_zone_a_nas 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'nas'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    ARecords: [
      {
        ipv4Address: edge_vm_public_ip
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dns_zone_a_status 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'status'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    ARecords: [
      {
        ipv4Address: edge_vm_public_ip
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}
