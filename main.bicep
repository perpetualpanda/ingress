param resourceGroupName string = 'rg-dns-pub-westus'
param dnsPrimaryZoneName string = 'ppanda.org'
param location string = 'westus'

module rgModule './modules/rg.bicep' = {
  name: 'rgDeployment'
  scope: subscription()
  params: {
    resourceGroupName: resourceGroupName
    location: location
  }
}

module dnsModule './modules/dns.bicep' = {
  name: 'dnsDeployment'
  scope: resourceGroupName
  params: {
    dnszones_primary_name: dnsPrimaryZoneName
  }
}
