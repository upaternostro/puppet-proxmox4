# == Class: proxmox::hypervisor::install
#
# Install Proxmox and inform the user he needs to reboot the system on the PVE kernel
#
class proxmox::hypervisor::install {

  Exec {
    path      => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
    logoutput => 'on_failure',
  }

  # If the system already run a PVE kernel
  ## Quoted boolean value because can't return "true" boolean with personal fact
  if $::is_pve_kernel == 'true' {

    # Installation of Virtual Environnment
    package { $proxmox::hypervisor::ve_pkg_name:
      ensure => $proxmox::hypervisor::ve_pkg_ensure,
    } ->

    # Remove useless packages (such as the standard kernel, acpid, ...)
    package { $proxmox::hypervisor::old_pkg_name:
      ensure => $proxmox::hypervisor::old_pkg_ensure,
      notify => Exec['update_grub'],
    }

    # Ensure that some recommended packages are present on the system
    ensure_packages( $proxmox::hypervisor::rec_pkg_name )

  }
  else { # If the system run on a standard Debian Kernel

    # To avoid unwanted reboot (kernel update for example), the PVE kernel is
    #  installed only if the system run on a standard Debian.
    # You will need to update your PVE kernel manually.

    # Installation of the PVE Kernel
    if $proxmox::hypervisor::kvm_only == true {
      notify { 'Please REBOOT':
        message  => "Need to REBOOT the system on the new PVE kernel (${proxmox::hypervisor::kernel_kvm_pkg_name}) ...",
        loglevel => warning,
      }
      ->
      package { $proxmox::hypervisor::kernel_kvm_pkg_name:
        ensure => $proxmox::hypervisor::ve_pkg_ensure,
        notify => Exec['update_grub'],
      }
    }
    else {
      notify { 'Please REBOOT':
        message  => "Need to REBOOT the system on the new PVE kernel (${proxmox::hypervisor::kernel_pkg_name}) ...",
        loglevel => warning,
      }
      ->
      package { $proxmox::hypervisor::kernel_pkg_name:
        ensure => $proxmox::hypervisor::ve_pkg_ensure,
        notify => Exec['update_grub','grub_reboot'],
      }
      # The kernel that allow KVM + OpenVZ is older than the standard Debian's
      #  kernel, so grub reboot must be used
    }

  }

  # Ensure the grub is update
  exec { 'update_grub':
    command     => 'update-grub',
    refreshonly => true,
  }

  # Choose a different line in the grub
  exec { 'grub_reboot':
    command     => 'grub-reboot 2',
    refreshonly => true,
  }


} # Private class: proxmox::hypervisor::install
