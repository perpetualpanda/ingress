@description('name of the dns zone resource')
param dns_zone_name string

@description('public ip of the edge vm')
param edge_vm_public_ip string

@description('ttl for the dns records')
param ttl int

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dns_zone_a_mc 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'mc'
  properties: {
    metadata: {
      purpose: 'minecraft-server'
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

resource dns_zone_a_nas 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: 'nas'
  properties: {
    metadata: {
      purpose: 'network-attached-storage'
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
      purpose: 'uptime-monitoring'
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
