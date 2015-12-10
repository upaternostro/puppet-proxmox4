# == Class: proxmox4::hypervisor
#
# Manage the Proxmox hypervisor.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { '::proxmox4::hypervisor':
#    kvm_only => true,
#  }
#
# === Authors
#
# Gardouille <gardouille@gmail.com>
#
# === Copyright
#
# WTFPL <http://wtfpl.org/>
#
class proxmox4::hypervisor (
  $ve_pkg_ensure              = $proxmox4::params::ve_pkg_ensure,
  $ve_pkg_name                = $proxmox4::params::ve_pkg_name,
  $kvm_only                   = $proxmox4::params::kvm_only,
  $kernel_kvm_pkg_name        = $proxmox4::params::kernel_kvm_pkg_name,
  $kernel_pkg_name            = $proxmox4::params::kernel_pkg_name,
  $rec_pkg_name               = $proxmox4::params::rec_pkg_name,
  $old_pkg_ensure             = $proxmox4::params::old_pkg_ensure,
  $old_pkg_name               = $proxmox4::params::old_pkg_name,
  $pve_enterprise_repo_ensure = $proxmox4::params::pve_enterprise_repo_ensure,
  $pveproxy_default_path      = $proxmox4::params::pveproxy_default_path,
  $pveproxy_default_content   = $proxmox4::params::pveproxy_default_content,
  $pveproxy_allow             = $proxmox4::params::pveproxy_allow,
  $pveproxy_deny              = $proxmox4::params::pveproxy_deny,
  $pveproxy_policy            = $proxmox4::params::pveproxy_policy,
  $pveproxy_service_name      = $proxmox4::params::pveproxy_service_name,
  $pveproxy_service_manage    = $proxmox4::params::pveproxy_service_manage,
  $pveproxy_service_enabled   = $proxmox4::params::pveproxy_service_enabled,
  $pve_modules_list           = $proxmox4::params::pve_modules_list,
  $pve_modules_file_path      = $proxmox4::params::pve_modules_file_path,
  $pve_modules_file_content   = $proxmox4::params::pve_modules_file_content,
  $vz_config_file_path        = $proxmox4::params::vz_config_file_path,
  $vz_config_file_tpl         = $proxmox4::params::vz_config_file_tpl,
  $vz_iptables_modules        = $proxmox4::params::vz_iptables_modules,
  $vz_service_name            = $proxmox4::params::vz_service_name,
  $vz_service_manage          = $proxmox4::params::vz_service_manage,
  $vz_service_enabled         = $proxmox4::params::vz_service_enabled,
  $labs_firewall_rule         = $proxmox4::params::labs_firewall_rule,
  $cluster_master_ip          = undef,
  $cluster_name               = undef,
) inherits proxmox4::params {

  include '::proxmox4::hypervisor::preconfig'
  include '::proxmox4::hypervisor::install'
  include '::proxmox4::hypervisor::config'
  include '::proxmox4::hypervisor::service'
  include '::proxmox4::hypervisor::cluster'

  Class['proxmox4::hypervisor::preconfig'] ->
  Class['proxmox4::hypervisor::install'] ->
  Class['proxmox4::hypervisor::config'] ->
  Class['proxmox4::hypervisor::service'] ->
  Class['proxmox4::hypervisor::cluster']

} # Public class: proxmox4::hypervisor
