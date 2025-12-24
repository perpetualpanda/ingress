@secure()
param admin_password  string
param admin_username  string
param cloud_init_data string
param name            string
param nic_id          string
param vm_size         string
param tags            object
param managed_id_name string
param subscription_id string = subscription().subscriptionId
param rg_name         string = resourceGroup().name

resource vm_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/${subscription_id}/resourceGroups/${rg_name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${managed_id_name}': {}
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
