targetScope = 'subscription'

@description('name of the vm managed id')
param edge_vm_managed_id_name string

@description('name of the vm resource group')
param edge_vm_resource_group_name string

@description('name of the dns resource group')
param dns_resource_group_name string

@description('name of the key vault resource')
param key_vault_name string

@description('project tags')
param tags object

@description('object id of the ci runner service principal')
param ci_service_principal_object_id string = '288b577e-7e6d-49d7-9c67-ea99e13549f1'

module resource_groups './misc/rg.bicep' = {
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

module key_vault './misc/kv.bicep' = {
  name: '${edge_vm_resource_group_name}-key-vault-deployment'
  scope: resourceGroup(edge_vm_resource_group_name)
  params: {
    key_vault_name: key_vault_name
    managed_id_name: edge_vm_managed_id_name
    ci_service_principal_object_id: ci_service_principal_object_id
    tags: tags
  }
  dependsOn: [ resource_groups ]
}
