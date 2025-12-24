param admin_username  string
param cloud_init_data string
param location        string
param name            string
param nic_id          string
param ssh_public_key  string
param vm_size         string
param tags            object

resource vm_resource 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
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
      customData: base64(cloud_init_data)
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${admin_username}/.ssh/authorized_keys'
              keyData: ssh_public_key
            }
          ]
        }
      }
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
