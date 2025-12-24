targetScope = 'subscription'

@secure()
param edge_vm_admin_password      string
param edge_vm_managed_id_name     string
param edge_vm_resource_group_name string
param edge_vm_key_vault_name      string
param dns_resource_group_name     string
param location                    string
param tags                        object

module resource_groups './bootstrap/rg.bicep' = {
  name: 'resource-groups-deployment'
  scope: subscription()
  params: {
    location: location
    rg_names:[
      dns_resource_group_name
      edge_resource_group_name
    ]
    tags: tags
  }
}

module key_vault './bootstrap/kv.bicep' = {
  name: '${edge_resource_group_name}-key-vault-deployment'
  scope: resourceGroup(edge_resource_group_name)
  params: {
    key_vault_name: edge_vm_key_vault_name
    managed_id_name: edge_vm_managed_id_name
    tags: tags
  }
  dependsOn: [ resource_groups ]
}

module edge_vm './edge-vm/main.bicep' = {
  name: '${edge_resource_group_name}-deployment'
  scope: resourceGroup(edge_resource_group_name)
  params: {
    admin_username: 'ppanda'
    admin_password: edge_vm_admin_password
    managed_id_name: edge_vm_managed_id_name
    cloud_init_data: loadTextContent('./templates/cloud-init.yml')
    subnet_cidr: '10.0.0.0/24'
    vm_size: 'Standard_B2s'
    vnet_cidr: '10.0.0.0/16'
    tags: tags
  }
  dependsOn: [ resource_groups, key_vault ]
}

module dns './dns/main.bicep' = {
  name: '${dns_resource_group_name}-deployment'
  scope: resourceGroup(dns_resource_group_name)
  params: {
    dns_zone_primary_name: 'ppanda.org'
    tags: tags
  }
  dependsOn: [ resource_groups ]
}
