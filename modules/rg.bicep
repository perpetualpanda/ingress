param resourceGroupName string = 'rg-dns-pub-westus'
param location string = 'westus'

resource rg_dns_resource 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    environment: 'public'
    project: 'homelab'
  }
}

output resourceGroupName string = rg_dns_resource.name
