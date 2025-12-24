param dns_zone_name string
param ttl int

var purpose = 'github-pages'

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dns_zone_a 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dns_zone
  name: '@'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    ARecords: [
      {
        ipv4Address: '185.199.108.153'
      }
      {
        ipv4Address: '185.199.109.153'
      }
      {
        ipv4Address: '185.199.110.153'
      }
      {
        ipv4Address: '185.199.111.153'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dns_zone_aaaa 'Microsoft.Network/dnszones/AAAA@2023-07-01-preview' = {
  parent: dns_zone
  name: '@'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    AAAARecords: [
      {
        ipv6Address: '2606:50c0:8000::153'
      }
      {
        ipv6Address: '2606:50c0:8001::153'
      }
      {
        ipv6Address: '2606:50c0:8002::153'
      }
      {
        ipv6Address: '2606:50c0:8003::153'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dns_zone_txt_github_pages_challenge 'Microsoft.Network/dnszones/TXT@2023-07-01-preview' = {
  parent: dns_zone
  name: '_github-pages-challenge-perpetualpanda'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    TXTRecords: [
      {
        value: [
          '000dcdf2686daed53910f406c6a20f'
        ]
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}
