@description('name of the vnet')
param name string

@description('address space of the vnet')
param address_space string

@description('subnet mask of the vnet')
param subnet_prefix string

@description('project tags')
param tags object

resource vnet_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        address_space
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: subnet_prefix
        }
      }
    ]
  }
}

output subnet_id string = vnet_resource.properties.subnets[0].id
