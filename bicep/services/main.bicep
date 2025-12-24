targetScope = 'subscription'

@secure()
param edge_vm_admin_password      string
param edge_vm_managed_id_name     string
param edge_vm_resource_group_name string
param dns_resource_group_name     string
param tags                        object

module edge_vm './edge-vm/main.bicep' = {
  name: '${edge_vm_resource_group_name}-deployment'
  scope: resourceGroup(edge_vm_resource_group_name)
  params: {
    admin_username: 'ppanda'
    admin_password: edge_vm_admin_password
    managed_id_name: edge_vm_managed_id_name
    cloud_init_data: loadTextContent('../templates/cloud-init.yml')
    subnet_cidr: '10.0.0.0/24'
    vm_size: 'Standard_B2s'
    vnet_cidr: '10.0.0.0/16'
    tags: tags
  }
}

module dns './dns/main.bicep' = {
  name: '${dns_resource_group_name}-deployment'
  scope: resourceGroup(dns_resource_group_name)
  params: {
    dns_zone_primary_name: 'ppanda.org'
    tags: tags
  }
}
