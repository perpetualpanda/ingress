targetScope = 'subscription'

param edge_vm_managed_id_name     string
param edge_vm_resource_group_name string
param dns_resource_group_name     string
param tags                        object

module resource_groups './rg.bicep' = {
  name: 'resource-groups-deployment'
  scope: subscription()
  params: {
    location: deployment().location
    rg_names:[
      dns_resource_group_name
      edge_vm_resource_group_name
    ]
    tags: tags
  }
}

module key_vault './kv.bicep' = {
  name: '${edge_vm_resource_group_name}-key-vault-deployment'
  scope: resourceGroup(edge_vm_resource_group_name)
  params: {
    key_vault_name: 'kv-edge-pub-${deployment().location}'
    managed_id_name: edge_vm_managed_id_name
    ci_service_principal_id: 'efc8dd45-b094-4d96-bc95-cc56d49e6b20'
    tags: tags
  }
  dependsOn: [ resource_groups ]
}
