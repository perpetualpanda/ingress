param dns_zone resource
param ttl int

var purpose = 'protonmail'

resource dnszones_primary_name_protonmail_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dns_zone
  name: 'protonmail._domainkey'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    CNAMERecord: {
      cname: 'protonmail.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_protonmail2_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dns_zone
  name: 'protonmail2._domainkey'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    CNAMERecord: {
      cname: 'protonmail2.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_protonmail3_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dns_zone
  name: 'protonmail3._domainkey'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    CNAMERecord: {
      cname: 'protonmail3.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_MX_dnszones_primary_name 'Microsoft.Network/dnszones/MX@2023-07-01-preview' = {
  parent: dns_zone
  name: '@'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    MXRecords: [
      {
        exchange: 'mail.protonmail.ch'
        preference: 10
      }
      {
        exchange: 'mailsec.protonmail.ch'
        preference: 20
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_TXT_dnszones_primary_name 'Microsoft.Network/dnszones/TXT@2023-07-01-preview' = {
  parent: dns_zone
  name: '@'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    TXTRecords: [
      {
        value: [
          'protonmail-verification=b93e1e9a06d1776b86ad3a484de0c2968f25c1ab'
        ]
      }
      {
        value: [
          'v=spf1 include:_spf.protonmail.ch mx ~all'
        ]
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_dmarc 'Microsoft.Network/dnszones/TXT@2023-07-01-preview' = {
  parent: dns_zone
  name: '_dmarc'
  properties: {
    metadata: {
      purpose: purpose
    }
    TTL: ttl
    TXTRecords: [
      {
        value: [
          'v=DMARC1; p=quarantine'
        ]
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}
