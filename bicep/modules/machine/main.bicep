@description('suffix for the vm resource names')
param name_suffix string = 'edge-pub-${resourceGroup().location}'

@description('admin username for the vm')
param admin_username string

@secure()
@description('admin password for the vm')
param admin_password string

@description('name of the user assigned managed id for the vm')
param managed_id_name string

@description('cloud-init config string')
param cloud_init_data string

@description('cidr of the subnet mask')
param subnet_cidr string

@description('cidr of the vnet address space')
param vnet_cidr string

@description('azure vm size')
param vm_size string

@description('project tags')
param tags object

module nsg './nsg.bicep' = {
  name: 'nsg-deployment'
  params: {
    name: 'nsg-${name_suffix}'
    tags: tags
  }
}

module vnet './vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    name: 'vnet-${name_suffix}'
    address_space: vnet_cidr
    subnet_prefix: subnet_cidr
    tags: tags
  }
}

module public_ip './pubip.bicep' = {
  name: 'public-ip-deployment'
  params: {
    name: 'ip-${name_suffix}'
    tags: tags
  }
}

module nic './nic.bicep' = {
  name: 'nic-deployment'
  params: {
    name: 'nic-${name_suffix}'
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
    vm_size: vm_size
    admin_username: admin_username
    admin_password: admin_password
    managed_id_name: managed_id_name
    cloud_init_data: cloud_init_data
    nic_id: nic.outputs.nic_id
    tags: tags
  }
}

output edge_vm_public_ip string = public_ip.outputs.public_ip_address
