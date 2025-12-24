param name     string
param tags     object

resource nsg_resource 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'allow-https'
        properties: {
          protocol: 'tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'allow'
          priority: 300
          direction: 'Inbound'
        }
      }
      {
        name: 'allow-http'
        properties: {
          protocol: 'tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'allow'
          priority: 320
          direction: 'inbound'
        }
      }
    ]
  }
}

output nsg_id string = nsg_resource.id
