# Fact: vznetwork
#
# Purpose:
#   Get networks for Virtual Network aka venet in OpenVZ CT, for available
#   network networks
#
# Resolution:
#   Uses `facter/util/ip` to enumerate interfaces and return their information.
#
require 'facter/util/ip'
require 'ipaddr'

Facter::Util::IP.get_interfaces.each do |interface|
  Facter.add("vznetwork_" + Facter::Util::IP.alphafy(interface)) do
    setcode do
      if interface =~ /^venet*/

        ipaddress = Facter::Util::IP.get_interface_value(interface, "ipaddress")
        netmask = Facter::Util::IP.get_interface_value(interface, "netmask")
        if netmask == "255.255.255.255"
          # It's not possible to modify the netmask from WebGUI, so it's mainly set to /32
          # http://openvz.org/Venet#Adding_IP_address_to_a_container
          netmask = "255.255.255.0"
        end

        if ipaddress && netmask
          ip = IPAddr.new(ipaddress, Socket::AF_INET)
          subnet = IPAddr.new(netmask, Socket::AF_INET)
          ip.mask(subnet.to_s).to_s
        end

      end
    end
  end
end
