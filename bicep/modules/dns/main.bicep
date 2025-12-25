@description('name of the dns zone resource')
param dns_zone_name string

@description('public ip of the edge vm')
param edge_vm_public_ip string

module dns_zone_primary './zone.bicep' = {
  name: 'dns-zone-deployment'
  params: {
    dns_zone_primary_name: dns_zone_primary_name
    tags: tags
  }
}

module dns_discord './discord.bicep' = {
  name: 'dns-discord-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 3600
  }
  dependsOn: [ dns_zone_primary ]
}

module dns_gh_pages './ghpages.bicep' = {
  name: 'dns-gh-pages-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 3600
  }
  dependsOn: [ dns_zone_primary ]
}

module dns_protonmail './protonmail.bicep' = {
  name: 'dns-protonmail-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 3600
  }
  dependsOn: [ dns_zone_primary ]
}

module dns_services './services.bicep' = {
  name: 'dns-services-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    edge_vm_public_ip: edge_vm_public_ip
    ttl: 300
  }
  dependsOn: [ dns_zone_primary ]
}
