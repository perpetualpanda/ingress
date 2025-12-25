targetScope = 'subscription'

@description('names of the resource groups to create')
param rg_names array

@description('azure location to create the resource groups in')
param location string

@description('project tags')
param tags object

resource resource_groups 'Microsoft.Resources/resourceGroups@2025-04-01' = [
  for rg_name in rg_names: {
    name: rg_name
    location: location
    tags: tags
  }
]
