targetScope = 'subscription'

@description('Azure region for deployment')
param location string = 'westus'

@description('Resource group name for DNS deployment')
param dns_resource_group_name string = 'rg-dns-pub-westus'

@description('Resource group name for reverse proxy vm deployment')
param edge_resource_group_name string = 'rg-edge-pub-westus'

@description('Metadata tags for the project')
param tags object = {
  deployment_type: 'automated'
  environment: 'public'
  project: 'homelab'
  purpose: 'public-ingress'
}

resource dnsResourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: dns_resource_group_name
  location: location
  tags: tags
}

resource edgeResourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: edge_resource_group_name
  location: location
  tags: tags
}
