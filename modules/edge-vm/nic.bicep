param name string
param location string
param subnet_id string
param public_ip_id string
param nsg_id string

resource nic_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig0'
        properties: {
          subnet: {
            id: subnet_id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: public_ip_id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg_id
    }
  }
}

output nic_id string = nic.id
