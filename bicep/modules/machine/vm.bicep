@description('name of the vm')
param name string

@description('admin username for the vm')
param admin_username string

@secure()
@description('admin password for the vm')
param admin_password string

@description('cloud-init config string')
param cloud_init_data string

@description('id of the nic resource')
param nic_id string

@description('azure vm size')
param vm_size string

@description('name of the user assigned managed id for the vm')
param managed_id_name string

@description('project tags')
param tags object

resource vm_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${managed_id_name}': {}
    }
  }
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-minimal-jammy'
        sku: 'minimal-22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        diskSizeGB: 30
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    osProfile: {
      computerName: name
      adminUsername: admin_username
      adminPassword: admin_password
      customData: base64(cloud_init_data)
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic_id
        }
      ]
    }
  }
}
