param admin_username string = 'ppanda'
param location       string = 'westus'
param name_suffix    string = 'edge-pub-${location}'
param subnet_cidr    string = '10.0.0.0/24'
param vm_size        string = 'Standard_B2s'
param vnet_cidr      string = '10.0.0.0/16'
param ssh_public_key string // passed from gh secrets

module nsg './nsg.bicep' = {
  name: 'nsg_deployment'
  params: {
    name: 'nsg-${name_suffix}'
    location: location
  }
}

module vnet './vnet.bicep' = {
  name: 'vnet_deployment'
  params: {
    name: 'vnet-${name_suffix}'
    location: location
    address_space: vnet_cidr
    subnet_prefix: subnet_cidr
  }
}

module public_ip './pubip.bicep' = {
  name: 'public_ip_deployment'
  params: {
    name: 'ip-${name_suffix}'
    location: location
  }
}

module nic './nic.bicep' = {
  name: 'nic_deployment'
  params: {
    name: 'nic-${name_suffix}'
    location: location
    subnet_id: vnet.outputs.subnet_id
    public_ip_id: public_ip.outputs.public_ip_id
    nsg_id: nsg.outputs.nsg_id
  }
}

module vm './vm.bicep' = {
  name: 'vm_deployment'
  params: {
    name: 'vm-${name_suffix}'
    location: location
    vm_size: vm_size
    admin_username: admin_username
    ssh_public_key: ssh_public_key
    nic_id: nic.outputs.nic_id
  }
}
