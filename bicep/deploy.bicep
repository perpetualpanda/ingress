targetScope = 'subscription'

@secure()
@description('initial admin password for the vm')
param edge_vm_admin_password string

@description('suffix to use for resource names')
param resource_name_suffix string

@description('name of the key vault resource')
param key_vault_name string

@description('name of the key vault tailscale secret key')
param tailscale_auth_vault_key string

@description('project tags')
param tags object

// replace placeholder values in the cloud-init template
var raw1 = loadTextContent('./templates/cloud-init.yml')
var raw2 = replace(raw1, '<PLACEHOLDER_TS_VAULT_NAME>', key_vault_name)
var cloud_init_data = replace(raw2,'<PLACEHOLDER_TS_VAULT_KEY>', tailscale_auth_vault_key)

module edge_vm './modules/machine/main.bicep' = {
  name: 'rg-vm-${resource_name_suffix}-deployment'
  scope: resourceGroup('rg-vm-${resource_name_suffix}')
  params: {
    admin_username: 'ppanda'
    admin_password: edge_vm_admin_password
    managed_id_name: 'mi-${resource_name_suffix}'
    name_suffix: resource_name_suffix
    cloud_init_data: cloud_init_data
    subnet_cidr: '10.0.0.0/24'
    vm_size: 'Standard_B2s'
    vnet_cidr: '10.0.0.0/16'
    tags: tags
  }
}

module dns './modules/dns/main.bicep' = {
  name: 'rg-dns-${resource_name_suffix}-deployment'
  scope: resourceGroup('rg-dns-${resource_name_suffix}')
  params: {
    edge_vm_public_ip: edge_vm.outputs.edge_vm_public_ip
    dns_zone_primary_name: 'ppanda.org'
    tags: tags
  }
}
