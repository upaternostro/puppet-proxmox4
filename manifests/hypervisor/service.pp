# == Class: proxmox::hypervisor::service
#
# Manage Proxmox services
#
class proxmox::hypervisor::service {


  if $proxmox::hypervisor::pveproxy_service_enabled == true {
    $pveproxy_service_ensure = 'running'
  } else {
    $pveproxy_service_ensure = 'stopped'
  }

  if $proxmox::hypervisor::vz_service_enabled == true {
    $vz_service_ensure = 'running'
  } else {
    $vz_service_ensure = 'stopped'
  }


  if $::is_proxmox == 'true' {

    if $proxmox::hypervisor::pveproxy_service_manage == true {
      service { $proxmox::hypervisor::pveproxy_service_name:
        ensure     => $pveproxy_service_ensure,
        enable     => $proxmox::hypervisor::pveproxy_service_enabled,
        hasstatus  => false,
        hasrestart => true,
      }
    }

    if $proxmox::hypervisor::vz_service_manage == true {
      service { $proxmox::hypervisor::vz_service_name:
        ensure     => $vz_service_ensure,
        enable     => $proxmox::hypervisor::pveproxy_service_enabled,
        hasstatus  => true,
        hasrestart => true,
      }
    }

  }



} # Private class: proxmox::hypervisor::service
