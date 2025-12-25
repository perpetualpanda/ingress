@description('name of the nic')
param name string

@description('id of the subnet resource')
param subnet_id string

@description('id of the public ip resource')
param public_ip_id string

@description('id of the network security group resource')
param nsg_id string

@description('project tags')
param tags object

resource nic_resource 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
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

output nic_id string = nic_resource.id
