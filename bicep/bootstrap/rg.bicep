targetScope = 'subscription'

param rg_names array
param location string
param tags object

resource resource_groups 'Microsoft.Resources/resourceGroups@2025-04-01' = [
  for rg_name in rg_names: {
    name: rg_name
    location: location
    tags: tags
  }
]
