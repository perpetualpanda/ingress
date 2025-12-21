@description('Name of the primary dns zone (e.g. example.com)')
param dnszones_primary_name string

@description('Metadata tags for the primary name resource')
param tags object

resource dnszones_primary_name_resource 'Microsoft.Network/dnszones@2023-07-01-preview' = {
  name: dnszones_primary_name
  location: 'global'
  tags: tags
  properties: {
    zoneType: 'Public'
  }
}

resource Microsoft_Network_dnszones_A_dnszones_primary_name 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: '@'
  properties: {
    metadata: {
      purpose: 'github-pages'
    }
    TTL: 3600
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

resource dnszones_primary_name_nas 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: 'nas'
  properties: {
    metadata: {
      purpose: 'public-homelab-service'
    }
    TTL: 300
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
  parent: dnszones_primary_name_resource
  name: 'status'
  properties: {
    metadata: {
      purpose: 'public-homelab-service'
    }
    TTL: 300
    ARecords: [
      {
        ipv4Address: '140.82.45.8'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_AAAA_dnszones_primary_name 'Microsoft.Network/dnszones/AAAA@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: '@'
  properties: {
    metadata: {
      purpose: 'github-pages'
    }
    TTL: 3600
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

resource dnszones_primary_name_protonmail_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: 'protonmail._domainkey'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
    CNAMERecord: {
      cname: 'protonmail.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_protonmail2_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: 'protonmail2._domainkey'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
    CNAMERecord: {
      cname: 'protonmail2.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource dnszones_primary_name_protonmail3_domainkey 'Microsoft.Network/dnszones/CNAME@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: 'protonmail3._domainkey'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
    CNAMERecord: {
      cname: 'protonmail3.domainkey.d3wxy5ytci2hzufheo7wcxxinbvkv4cso2g5ddycqj7gqiuta7n2q.domains.proton.ch'
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_MX_dnszones_primary_name 'Microsoft.Network/dnszones/MX@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: '@'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
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
  parent: dnszones_primary_name_resource
  name: '@'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
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
  parent: dnszones_primary_name_resource
  name: '_dmarc'
  properties: {
    metadata: {
      purpose: 'protonmail'
    }
    TTL: 3600
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

resource dnszones_primary_name_github_pages_challenge_perpetualpanda 'Microsoft.Network/dnszones/TXT@2023-07-01-preview' = {
  parent: dnszones_primary_name_resource
  name: '_github-pages-challenge-perpetualpanda'
  properties: {
    metadata: {
      purpose: 'github-pages'
    }
    TTL: 3600
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
