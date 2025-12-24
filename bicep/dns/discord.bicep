param dns_zone_name string
param ttl int

var purpose = 'discord'

resource dns_zone 'Microsoft.Network/dnszones@2023-07-01-preview' existing = {
  name: dns_zone_name
}

resource dns_zone_txt_discord 'Microsoft.Network/dnszones/TXT@2023-07-01-preview' = {
  parent: dns_zone
  name: '_discord'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    TXTRecords: [
      {
        value: [
          'dh=858c21a0d46a148e82628b0ebddcbffe46390a07'
        ]
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}
