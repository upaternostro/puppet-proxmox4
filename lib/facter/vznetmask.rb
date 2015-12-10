# Fact: vznetmask
#
# Purpose:
#   Get netmasks for Virtual Network aka venet in OpenVZ CT, for available
#   network networks
#
# Resolution:
#   Uses `facter/util/ip` to enumerate interfaces and return their information.
#
require 'facter/util/ip'
require 'ipaddr'

Facter::Util::IP.get_interfaces.each do |interface|
  Facter.add("vznetmask_" + Facter::Util::IP.alphafy(interface)) do
    setcode do
      if interface =~ /^venet*/

        netmask = Facter::Util::IP.get_interface_value(interface, "netmask")
        if netmask == "255.255.255.255"
          # It's not possible to modify the netmask from WebGUI, so it's mainly set to /32
          # http://openvz.org/Venet#Adding_IP_address_to_a_container
          netmask = "255.255.255.0"
        end

      end
      netmask
    end
  end
end
