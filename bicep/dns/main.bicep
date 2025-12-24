param dns_zone_primary_name string
param tags                  object

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
}

module dns_gh_pages './ghpages.bicep' = {
  name: 'dns-gh-pages-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 3600
  }
}

module dns_protonmail './protonmail.bicep' = {
  name: 'dns-protonmail-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 3600
  }
}

module dns_services './services.bicep' = {
  name: 'dns-services-deployment'
  params: {
    dns_zone_name: dns_zone_primary_name
    ttl: 300
  }
}
