param name     string
param tags     object

resource public_ip_resource 'Microsoft.Network/publicIPAddresses@2024-07-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

output public_ip_id      string = public_ip_resource.id
output public_ip_address string = public_ip_resource.properties.ipAddress
