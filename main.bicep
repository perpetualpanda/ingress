module rgModule './modules/rg.bicep' = {
  name: 'rgDeployment'
  scope: subscription()
  params: {
    resourceGroupName: 'rg-dns-pub-westus'
    location: 'westus'
  }
}

module dnsModule './modules/dns.bicep' = {
  name: 'dnsDeployment'
  scope: resourceGroup(rgModule.outputs.resourceGroupName)
  params: {
    dnszones_primary_name: 'ppanda.org'
  }
}
