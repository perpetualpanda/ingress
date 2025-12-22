targetScope = 'subscription'

param location                 string
param dns_resource_group_name  string
param edge_resource_group_name string
param tags                     object

resource dns_resource_group 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: dns_resource_group_name
  location: location
  tags: tags
}

resource edge_resource_group 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: edge_resource_group_name
  location: location
  tags: tags
}
