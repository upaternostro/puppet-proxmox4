# == Class: proxmox4::vm
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
# include proxmox4::vm
#
# === Authors
#
# Gardouille <gardouille@gmail.com>
#
# Copyright
#
# WTFPL <http://wtfpl.org/>
#
class proxmox4::vm (
  $vm_interfaces_path         = $proxmox4::params::vm_interfaces_path,
  $vm_interfaces_content      = $proxmox4::params::vm_interfaces_content,
  $vm_interfaces_tail_path    = $proxmox4::params::vm_interfaces_tail_path,
  $vm_interfaces_tail_content = $proxmox4::params::vm_interfaces_tail_content,
  $network_service_name       = $proxmox4::params::network_service_name,
  $network_service_manage     = $proxmox4::params::network_service_manage,
  $network_service_enabled    = $proxmox4::params::network_service_enabled,
) inherits proxmox4::params {

  case $::virtual {
    'openvz': {
      include proxmox4::vm::openvz
    }
    'kvm': {
    }
    default: {
      fail(" => ${::virtual} <= virtual machines type is not yet supported.")
    }

  }

} # Public class: proxmox4::vm
