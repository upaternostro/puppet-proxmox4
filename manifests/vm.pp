# == Class: proxmox::vm
#
# Manage Virtual Machines/VM (only OpenVZ right now)
#
# === Parameters
#
#
#
# === Variables
#
#
# === Examples
#
# include proxmox::vm
#
# === Authors
#
# Gardouille <gardouille@gmail.com>
#
# Copyright
#
# WTFPL <http://wtfpl.org/>
#
class proxmox::vm (
  $vm_interfaces_path         = $proxmox::params::vm_interfaces_path,
  $vm_interfaces_content      = $proxmox::params::vm_interfaces_content,
  $vm_interfaces_tail_path    = $proxmox::params::vm_interfaces_tail_path,
  $vm_interfaces_tail_content = $proxmox::params::vm_interfaces_tail_content,
  $network_service_name       = $proxmox::params::network_service_name,
  $network_service_manage     = $proxmox::params::network_service_manage,
  $network_service_enabled    = $proxmox::params::network_service_enabled,
) inherits proxmox::params {

  case $::virtual {
    'openvz': {
      include proxmox::vm::openvz
    }
    'kvm': {
    }
    default: {
      fail(" => ${::virtual} <= virtual machines type is not yet supported.")
    }

  }

} # Public class: proxmox::vm
