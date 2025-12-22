param name string
param location string
param address_space string
param subnet_prefix string

resource vnet_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: name
  location: location
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
