
---------------------------------------

### 0.2.4

##### Features
* Latest release for Proxmox 3.x. Please be careful with the next release!

##### Changes
* Upgrade pve-kernel-3.10.0-13-pve and pve-kernel-2.6.32-43 to the last version.

---------------------------------------

### 0.2.3 - 2015/06/01

##### Features
* New fact is_pve_kernel check if the running kernel is a PVE.

##### Changes
* Some installation's instructions only run if running a PVE kernel (test the new is_pve_kernel fact).
* Use the stdlib function 'ensure_packages' to install recommended packages instead of 'if ! defined'.
* Upgrade pve-kernel-3.10.0-9-pve and pve-kernel-2.6.32-39 to the last version.
* Correct puppet-lint warnings.

##### Bugfixes
* #14 The module no longer automatically reboot nodes after kernel upgrade, show a warning message instead.

---------------------------------------

### 0.2.2 - 2015/03/25

##### Features
* A new subclass to automates the creation of a cluster from the master and join from other nodes.

##### Changes
* Update README.md.
* Upgrade pve-kernel-3.10.0-8-pve and pve-kernel-2.6.32-37 to the last version.
* Puppet-lint
* Add a case for 'kvm' VM doesn't do anything right now, wait for specific (packages, config, …).

##### Bugfixes
* (#11) Add a new fact to get a valid netmask for OpenVZ's virtual interfaces (venet).
* (#11) Use the new fact vznetmask_venet0_0 to add the route in interfaces.tail file.

---------------------------------------
### 0.2.1 - 2015/02/03

##### Features
* Manage the main OpenVZ's configuration file (/etc/vz/vz.conf).
* Add vz service management.

##### Changes
* The network management for an OpenVZ CT now works for all Debian family and not only Debian >=7.
* Modification in OpenVZ's configuration file notify the 'vz' service.
* Set an option to manage iptables modules in OpenVZ configuration.
* Correct puppet-lint warnings.

---------------------------------------
### 0.2.0 - 2015/01/27

#### Summary
This release introduce a new subclasse for OpenVZ CT (network management):

    include proxmox::vm

It's also provide a array of kernel modules added at the boot start.

##### Features
* (#2) Add an array and a file to load additionnal modules.
* (#9) Add a puppetlabs-firewall rule.
* (#3) Add a new class and subclass: proxmox::vm::openvz to manage OpenVZ CT.
* (#3) Add a new fact to calculate venet's network with /24 instead of /32.)
* Add many modules (mainly for iptables) to load at startup (sea README.md).

##### Bugfixes
* Correct module's dependencies.
* Run the proxmox::hypervisor::group only if PVE is installed.

##### Changes
* README.md: Add examples, a table of contents, information about proxmox::vm::openvz (#3).
* Correct indentation, double quote, ...

---------------------------------------

### 0.1.0 - 2015/01/15

This release introduce new defined types:

    proxmox::hypervisor::group { 'sysadmin':
      role  => 'Administrator',
      users => [ 'root@pam', 'test@pve' ],
    }

    proxmox::hypervisor::user { 'toto@pve':
      group => 'sysadmin',
    }

And also directly jump to 0.1.0, the module allow to manage a simple Proxmox hypervisor right now.

##### Changes
* Add a variable to choose to keep PVE enterprise repo for the subscribers.
* (#4) Add an access control list for PveProxy.
* (#4) Add a new class to manage Proxmox's service (proxmox::hypervisor::service).
* (#6) Add a new defined type to manage groups for PVE WebGUI.
* (#7) Add a new defined type to manage users for PVE WebGUI.
* Update the README.md file for (#6) group and (#7) user defined types.
* Add a test for (#6) group and (#7) user defined types.

---------------------------------------

### 0.0.2 - 2015/01/08

New functionality release, Proxmox installation now working :)

##### Changes
* (#1) Possibility to choose between newer kernel that only supports KVM or a ~2.6.32 that supports both KVM and OpenVZ.
* (#1) Install the Virtual Environment and it's works with 2 puppet run.
* Add new test (hypervisor_kvm_only).
* Add a fact to check if Proxmox is "available".
* Add a new class: proxmox::hypervisor::config for some tiny configurations.
* Remove the subscription message in the web gui.
* Add operatingsystem_support information in the metadata.json (to correct the error in Metadata Quality).
* Correct wtfpl into WTFPL to be recognized by SPDX (Metadata Quality).
* Correct indentation, double quote, ...

---------------------------------------

### 0.0.1 - 2015/01/07

Initial release.

##### Changes
* Only prepare the system for Proxmox installation (proxmox::hypervisor::preconfig)
