targetScope = 'subscription'

@description('name of the vm managed id')
param edge_vm_managed_id_name string

@description('suffix to use for resource names')
param resource_name_suffix string

@description('name of the key vault resource')
param key_vault_name string

@description('project tags')
param tags object

@description('object id of the ci runner service principal')
param ci_service_principal_object_id string = 'efc8dd45-b094-4d96-bc95-cc56d49e6b20'

module resource_groups './modules/misc/rg.bicep' = {
  name: 'resource-groups-deployment'
  scope: subscription()
  params: {
    location: deployment().location
    rg_names:[
      'rg-dns-${resource_name_suffix}'
      'rg-vm-${resource_name_suffix}'
    ]
    tags: tags
  }
}

module key_vault './modules/misc/kv.bicep' = {
  name: 'rg-vm-${resource_name_suffix}-kv-deployment'
  scope: resourceGroup(edge_vm_resource_group_name)
  params: {
    key_vault_name: key_vault_name
    managed_id_name: edge_vm_managed_id_name
    ci_service_principal_object_id: ci_service_principal_object_id
    tags: tags
  }
  dependsOn: [ resource_groups ]
}
