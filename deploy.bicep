targetScope = 'subscription'

@secure()
@description('initial admin password for the vm')
param edge_vm_admin_password string

@description('name of the user assigned managed id for the vm')
param edge_vm_managed_id_name string

@description('name of the vm resource group')
param edge_vm_resource_group_name string

@description('name of the dns resource group')
param dns_resource_group_name string

@description('name of the key vault resource')
param key_vault_name string

@description('name of the key vault tailscale secret key')
param tailscale_auth_vault_key string

@description('project tags')
param tags object

var raw = loadTextContent('./templates/cloud-init.yml')
var raw2 = replace(raw, '<PLACEHOLDER_TS_VAULT_NAME>', key_vault_name)
var cloud_init_data = replace(raw2,'<PLACEHOLDER_TS_VAULT_KEY>', tailscale_auth_vault_key)

module edge_vm './modules/machine/main.bicep' = {
  name: '${edge_vm_resource_group_name}-deployment'
  scope: resourceGroup(edge_vm_resource_group_name)
  params: {
    admin_username: 'ppanda'
    admin_password: edge_vm_admin_password
    managed_id_name: edge_vm_managed_id_name
    cloud_init_data: cloud_init_data
    subnet_cidr: '10.0.0.0/24'
    vm_size: 'Standard_B2s'
    vnet_cidr: '10.0.0.0/16'
    tags: tags
  }
}

module dns './modules/dns/main.bicep' = {
  name: '${dns_resource_group_name}-deployment'
  scope: resourceGroup(dns_resource_group_name)
  params: {
    edge_vm_public_ip: edge_vm.outputs.edge_vm_public_ip
    dns_zone_primary_name: 'ppanda.org'
    tags: tags
  }
}
