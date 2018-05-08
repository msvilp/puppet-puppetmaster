# Setup standalone Puppetserver without anything else extra
#
# == Parameters:
#
# $manage_packetfilter:: Manage IPv4 and IPv6 rules. Defaults to true.
#
# $server_reports:: Where to store reports. Defaults to 'store'.
#
# $autosign:: Set up autosign entries. Set to true to enable naive autosigning.
#
# $autosign_entries:: List of autosign entries. Requires that autosign is pointing to the path of autosign.conf.
#
# $timezone:: The timezone the server wants to be located in. Example: 'Europe/Helsinki' or 'Etc/UTC'.
#
class puppetmaster::puppetserver
(
  Boolean                  $manage_packetfilter = true,
  String                   $server_reports = 'store',
  Variant[Boolean, String] $autosign = '/etc/puppetlabs/puppet/autosign.conf',
  Optional[Array[String]]  $autosign_entries = undef,
  String                   $timezone,
)
{
  $primary_names = [ "${facts['fqdn']}", "${facts['hostname']}", 'puppet', "puppet.${facts['domain']}" ]  

  unless defined(Class['::puppetmaster::common']) {
    
    class { '::puppetmaster::common':
      manage_packetfilter => $manage_packetfilter,
      primary_names       => $primary_names,
      timezone            => $timezone,
   }
  }
  
  class { '::puppet':
    server                => true,
    show_diff             => false,
    server_foreman        => false,
    autosign              => $autosign,
    autosign_entries      => $autosign_entries,
    server_external_nodes => '',
    server_reports        => $server_reports,
    require               => [ File['/etc/puppetlabs/puppet/fileserver.conf'], Puppet_authorization::Rule['files'] ],
  }
}
