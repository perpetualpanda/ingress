param admin_username      string
param location            string
param subnet_cidr         string
param vnet_cidr           string
param vm_size             string
param ssh_public_key      string
param tags                object
param name_suffix         string = 'edge-pub-${location}'

module nsg './nsg.bicep' = {
  name: 'nsg-deployment'
  params: {
    name: 'nsg-${name_suffix}'
    location: location
    tags: tags
  }
}

module vnet './vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    name: 'vnet-${name_suffix}'
    location: location
    address_space: vnet_cidr
    subnet_prefix: subnet_cidr
    tags: tags
  }
}

module public_ip './pubip.bicep' = {
  name: 'public-ip-deployment'
  params: {
    name: 'ip-${name_suffix}'
    location: location
    tags: tags
  }
}

module nic './nic.bicep' = {
  name: 'nic-deployment'
  params: {
    name: 'nic-${name_suffix}'
    location: location
    subnet_id: vnet.outputs.subnet_id
    public_ip_id: public_ip.outputs.public_ip_id
    nsg_id: nsg.outputs.nsg_id
    tags: tags
  }
}

module vm './vm.bicep' = {
  name: 'vm-deployment'
  params: {
    name: 'vm-${name_suffix}'
    location: location
    vm_size: vm_size
    admin_username: admin_username
    ssh_public_key: ssh_public_key
    nic_id: nic.outputs.nic_id
    tags: tags
  }
}
