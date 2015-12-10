# == Class: proxmox::params
#
class proxmox::params {
  case $::osfamily {
    'Debian': {
      if $::operatingsystem == 'Debian' and versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        # Virtual Environment packages
        $ve_pkg_ensure              = 'present'
        $ve_pkg_name                = [ 'proxmox-ve-2.6.32', 'ksm-control-daemon', 'vzprocps', 'open-iscsi', 'bootlogd', 'pve-firmware' ]

        # PVE Kernel
        $kvm_only                   = false
        $kernel_kvm_pkg_name        = [ 'pve-kernel-3.10.0-13-pve' ]
        $kernel_pkg_name            = [ 'pve-kernel-2.6.32-43' ]

        # Recommended packages
        $rec_pkg_name               = [ 'ntp', 'ssh', 'lvm2', 'bridge-utils' ]

        # Old useless packages
        $old_pkg_ensure             = 'absent'
        $old_pkg_name               = [ 'acpid',  'linux-image-amd64', 'linux-base', 'linux-image-3.2.0-4-amd64' ]

        # Manage PVE Enterprise repository (need a subscription)
        $pve_enterprise_repo_ensure = 'absent'

        # Pveproxy access restriction
        $pveproxy_default_path      = '/etc/default/pveproxy'
        $pveproxy_default_content   = 'proxmox/hypervisor/pveproxy_default.erb'
        $pveproxy_allow             = '127.0.0.1'
        $pveproxy_deny              = 'all'
        $pveproxy_policy            = 'allow'
        $pveproxy_service_name      = 'pveproxy'
        $pveproxy_service_manage    = true
        $pveproxy_service_enabled   = true

        # Manage additionnals modules
        $pve_modules_list           = [ 'iptable_filter', 'iptable_mangle', 'iptable_nat', 'ipt_length', 'ipt_limit', 'ipt_LOG', 'ipt_MASQUERADE', 'ipt_multiport', 'ipt_owner', 'ipt_recent', 'ipt_REDIRECT', 'ipt_REJECT', 'ipt_state', 'ipt_TCPMSS', 'ipt_tcpmss', 'ipt_TOS', 'ipt_tos', 'ip_conntrack', 'ip_nat_ftp', 'xt_iprange', 'xt_comment', 'ip6table_filter', 'ip6table_mangle', 'ip6t_REJECT' ]
        $pve_modules_file_path      = '/etc/modules-load.d/proxmox.conf'
        $pve_modules_file_content   = 'proxmox/hypervisor/proxmox_modules.conf.erb'

        # OpenVZ configuration
        $vz_config_file_path        = '/etc/vz/vz.conf'
        $vz_config_file_tpl         = 'proxmox/hypervisor/vz.conf.erb'
        $vz_iptables_modules        = true
        $vz_service_name            = 'vz'
        $vz_service_manage          = true
        $vz_service_enabled         = true

        # Firewall
        $labs_firewall_rule         = false

      }

      ## VM - OpenVZ
      # Network
      $vm_interfaces_path         = '/etc/network/interfaces'
      $vm_interfaces_content      = 'proxmox/vm/openzv_interfaces.erb'
      $vm_interfaces_tail_path    = '/etc/network/interfaces.tail'
      $vm_interfaces_tail_content = 'proxmox/vm/openzv_interfaces.tail.erb'
      $network_service_name       = 'networking'
      $network_service_manage     = true
      $network_service_enabled    = true

    }
    default: {
          fail("Proxmox Virtual Environment only works with Debian system; And the OpenVZ configuration has been tested only with Debian family; So osfamily (${::osfamily}) or lsbdistid (${::lsbdistid}) is unsupported")

    }

  }


} # Private class: proxmox::params
