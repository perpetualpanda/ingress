targetScope = 'subscription'

param ssh_public_key           string
param location                 string = 'westus'
param dns_resource_group_name  string = 'rg-dns-pub-westus'
param edge_resource_group_name string = 'rg-edge-pub-westus'
param tags                     object = {
  deployment_type: 'automated'
  environment: 'public'
  project: 'homelab'
  purpose: 'public-ingress'
}

module resource_groups './modules/groups/rg.bicep' = {
  name: 'resource-groups-deployment'
  scope: subscription()
  params: {
    location: location
    dns_resource_group_name: dns_resource_group_name
    edge_resource_group_name: edge_resource_group_name
    tags: tags
  }
}

module dns './modules/dns/dns.bicep' = {
  name: '${dns_resource_group_name}-deployment'
  scope: resourceGroup(dns_resource_group_name)
  params: {
    dnszones_primary_name: 'ppanda.org'
    tags: tags
  }
}

module edge_vm './modules/edge-vm/main.bicep' = {
  name: '${edge_resource_group_name}-deployment'
  scope: resourceGroup(edge_resource_group_name)
  params: {
    admin_username: 'ppanda'
    location: location
    ssh_public_key: ssh_public_key
    subnet_cidr: '10.0.0.0/24'
    vm_size: 'Standard_B2s'
    vnet_cidr: '10.0.0.0/16'
    tags: tags
  }
}
