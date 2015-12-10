# == Class: proxmox4::hypervisor::service
#
# Manage Proxmox services
#
class proxmox4::hypervisor::service {


  if $proxmox4::hypervisor::pveproxy_service_enabled == true {
    $pveproxy_service_ensure = 'running'
  } else {
    $pveproxy_service_ensure = 'stopped'
  }

  if $proxmox4::hypervisor::vz_service_enabled == true {
    $vz_service_ensure = 'running'
  } else {
    $vz_service_ensure = 'stopped'
  }


  if $::is_proxmox == 'true' {

    if $proxmox4::hypervisor::pveproxy_service_manage == true {
      service { $proxmox4::hypervisor::pveproxy_service_name:
        ensure     => $pveproxy_service_ensure,
        enable     => $proxmox4::hypervisor::pveproxy_service_enabled,
        hasstatus  => false,
        hasrestart => true,
      }
    }

    if $proxmox4::hypervisor::vz_service_manage == true {
      service { $proxmox4::hypervisor::vz_service_name:
        ensure     => $vz_service_ensure,
        enable     => $proxmox4::hypervisor::pveproxy_service_enabled,
        hasstatus  => true,
        hasrestart => true,
      }
    }

  }



} # Private class: proxmox4::hypervisor::service
