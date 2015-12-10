# == Class: proxmox::hypervisor
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
#  class { '::proxmox::hypervisor':
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
class proxmox::hypervisor (
  $ve_pkg_ensure              = $proxmox::params::ve_pkg_ensure,
  $ve_pkg_name                = $proxmox::params::ve_pkg_name,
  $kvm_only                   = $proxmox::params::kvm_only,
  $kernel_kvm_pkg_name        = $proxmox::params::kernel_kvm_pkg_name,
  $kernel_pkg_name            = $proxmox::params::kernel_pkg_name,
  $rec_pkg_name               = $proxmox::params::rec_pkg_name,
  $old_pkg_ensure             = $proxmox::params::old_pkg_ensure,
  $old_pkg_name               = $proxmox::params::old_pkg_name,
  $pve_enterprise_repo_ensure = $proxmox::params::pve_enterprise_repo_ensure,
  $pveproxy_default_path      = $proxmox::params::pveproxy_default_path,
  $pveproxy_default_content   = $proxmox::params::pveproxy_default_content,
  $pveproxy_allow             = $proxmox::params::pveproxy_allow,
  $pveproxy_deny              = $proxmox::params::pveproxy_deny,
  $pveproxy_policy            = $proxmox::params::pveproxy_policy,
  $pveproxy_service_name      = $proxmox::params::pveproxy_service_name,
  $pveproxy_service_manage    = $proxmox::params::pveproxy_service_manage,
  $pveproxy_service_enabled   = $proxmox::params::pveproxy_service_enabled,
  $pve_modules_list           = $proxmox::params::pve_modules_list,
  $pve_modules_file_path      = $proxmox::params::pve_modules_file_path,
  $pve_modules_file_content   = $proxmox::params::pve_modules_file_content,
  $vz_config_file_path        = $proxmox::params::vz_config_file_path,
  $vz_config_file_tpl         = $proxmox::params::vz_config_file_tpl,
  $vz_iptables_modules        = $proxmox::params::vz_iptables_modules,
  $vz_service_name            = $proxmox::params::vz_service_name,
  $vz_service_manage          = $proxmox::params::vz_service_manage,
  $vz_service_enabled         = $proxmox::params::vz_service_enabled,
  $labs_firewall_rule         = $proxmox::params::labs_firewall_rule,
  $cluster_master_ip          = undef,
  $cluster_name               = undef,
) inherits proxmox::params {

  include '::proxmox::hypervisor::preconfig'
  include '::proxmox::hypervisor::install'
  include '::proxmox::hypervisor::config'
  include '::proxmox::hypervisor::service'
  include '::proxmox::hypervisor::cluster'

  Class['proxmox::hypervisor::preconfig'] ->
  Class['proxmox::hypervisor::install'] ->
  Class['proxmox::hypervisor::config'] ->
  Class['proxmox::hypervisor::service'] ->
  Class['proxmox::hypervisor::cluster']

} # Public class: proxmox::hypervisor
