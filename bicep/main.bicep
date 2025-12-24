targetScope = 'subscription'

@secure()
param edge_vm_admin_password   string
param location                 string = 'westus'
param dns_resource_group_name  string = 'rg-dns-pub-${location}'
param edge_resource_group_name string = 'rg-edge-pub-${location}'
param tags                     object = {
  deployment_type: 'automated'
  environment: 'public'
  project: 'homelab'
  purpose: 'public-ingress'
}

var edge_vm_managed_id_name = 'mi-edge-pub-${location}'

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
    key_vault_name: 'kv-edge-pub-${location}'
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
