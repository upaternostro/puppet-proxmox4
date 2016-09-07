###

##### Features
* Add a small bootdelay to ensure a good detection of all LVM (with initramfs-tools).
* Rebuild all initrd if modification to initramfs-tools script.

##### Changes
* Upgrade to the last pve-kernel : pve-kernel-4.4.16-2-pve

---------------------------------------

### 0.1.0

##### Features
* Start this new module from the V3: https://git.101010.fr/puppet/proxmox

##### Changes
* Now use "proxmox4::…" instead of "proxmox::…"
* Doesn't need a specific kernel like ProxmoxV3. There is only a 4.x kernel.
* The PVE Kernel is newer than the default Debian one, so doesn't need grub-set-default anymore.
* Remove OpenVZ configuration for the Hypervisor.
* Ensure to run a 'full-upgrade' once repository added.
* Add Postfix to the recommended packages.
* Remove OpenVZ CT management.
* cluster.conf file no longer existes, use corosync.conf instead.
