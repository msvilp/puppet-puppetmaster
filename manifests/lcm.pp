# 
# Class to setup Foreman with a Smart Proxy
#
# == Parameters:
#
# $foreman_db_password:: The password for the foreman database.
#
# $foreman_admin_firstname:: The first name for Foreman Administator
#
# $foreman_admin_lastname:: The last name for Foreman Administator
# 
# $foreman_admin_email:: Foreman admin email
#
# $foreman_admin_password:: Foreman admin password
#
# $puppetdb_database_password:: Puppetdb database password
#
# $primary_names:: Primary names for this machine. Example: ['puppet.local', 'puppet' ]
#
# $timezone:: The timezone the server wants to be located in. Example: 'Europe/Helsinki' or 'Etc/UTC'. Defaults to 'Etc/UTC'
#
# == Advanced parameters:
#
# $foreman_plugin_cockpit:: Enable Cockpit plugin
#
# $foreman_compute_vmware:: Enable VMware computing resource
#
# $foreman_compute_libvirt:: Enable libvirt computing resource
#
# $foreman_compute_ec2:: Enable ec2 computing resource
#
# $foreman_compute_gce:: Enable Google Computing Engine computing resource
#
# $foreman_compute_openstack:: Enable Openstack computing resource
#
# $foreman_compute_ovirt:: Enable ovirt computing resource
#
# $foreman_compute_rackspace:: Enable Rackspace computing resource
#
# $foreman_plugin_azure:: Install support for Microsoft Azure
#
# $foreman_plugin_ansible:: Enable support for ansible
#
# $foreman_plugin_docker:: Enable support for Docker
#
# $foreman_plugin_bootdisk:: Enable support for bootdisk creation
# 
# $foreman_plugin_default_hostgroup:: Enable support for Foreman default hostgroups
#
# $foreman_plugin_dhcp_browser:: Enable support for dhcp record browser
#
# $foreman_plugin_digitalocean:: Enable support for Digital Ocean resources
#
# $foreman_plugin_discovery:: Enable support for Foreman discovery
#
# $foreman_plugin_hooks:: Enable support for Foreman hooks
#
# $foreman_plugin_memcache:: Enable support for Memcached
#
# $foreman_plugin_remote_execution:: Enable support for Foreman remote execution
#
# $foreman_plugin_tasks:: Enable support for Foreman Tasks
#
# $foreman_plugin_templates:: Enable support for foreman templates
#
# Foreman Proxy parameters
#
# $foreman_proxy_foreman_base_url:: The foreman URL the proxy wants to talk to 
#
# $foreman_proxy_templates:: Enable support for templates
#
# $foreman_proxy_templates_listen_on:: Adress to listen on for templates
#
# $foreman_proxy_trusted_hosts:: The hosts the proxy allows to talk
#
# $foreman_proxy_dhcp:: Enable support for dhcp
#
# $foreman_proxy_dhcp_listen_on:: Addresses to listen on for DHCP
#
# $foreman_proxy_dns:: Enable support for DNS
#
# $foreman_proxy_dhcp_managed:: Manage dhcp or not
#
# $foreman_proxy_dhcp_interface:: DHCP listening interfaces
#
# $foreman_proxy_dhcp_option_domain:: The domain for the dhcp
#
# $foreman_proxy_dhcp_search_domains:: The seach domains
#
# $foreman_proxy_dhcp_server:: The dhcp server
#
# $foreman_proxy_dhcp_provider:: The dhcp provider
#
# $foreman_proxy_dhcp_subnets:: The subnets for the dhcp
#
# $foreman_proxy_dhcp_gateway:: The default gateway 
#
# $foreman_proxy_dhcp_range:: The address range
#
# $foreman_proxy_dhcp_nameservers:: The name servers
#
# $foreman_proxy_dhcp_pxeserver:: The next server
#
# $foreman_proxy_dns_managed:: To manage the dns server or not
#
# $foreman_proxy_dns_forwarders:: The dns forwarders
#
# $foreman_proxy_dns_interface:: The dns interface(s) to listen on
#
# $foreman_proxy_dns_listen_on:: https, http, or both 
#
# $foreman_proxy_dns_provider:: DNS provider
#
# $foreman_proxy_dns_zone:: DNS zone name
#
# $foreman_proxy_dns_reverse:: DNS reverse zone name
#
# $foreman_proxy_dns_server:: Address of DNS server to manage
#
# $foreman_proxy_dns_ttl:: DNS default TTL override
#
# $foreman_proxy_tftp:: Enable TFTP feature
#
# $foreman_proxy_tftp_managed:: TFTP is managed by Foreman proxy
#
# $foreman_proxy_tftp_servername:: Defines the TFTP Servername to use, overrides the name in the subnet declaration
#
# $foreman_proxy_tftp_manage_wget:: If enabled will install the wget package
#
# $foreman_proxy_tftp_listen_on:: TFTP proxy to listen on https, http, or both
#
# $foreman_proxy_bmc:: Enable BMC feature
#
# $foreman_proxy_bmc_listen_on:: BMC proxy to listen on https, http, or both
#
# $foreman_proxy2_hostnames:: List of hostnames for additional smart proxy 2. Example [ 'foo2.example.com', 'foo2' ]
#
# $foreman_proxy2_ipaddress:: IP address of additional smart proxy 2. Example: '1.2.3.4'
#
# $foreman_proxy3_hostnames:: List of hostnames for additional smart proxy 3. Example [ 'foo3.example.com', 'foo3' ]
#
# $foreman_proxy3_ipaddress:: IP address of additional smart proxy 3. Example: '1.2.3.5'
#
# $foreman_proxy4_hostnames:: List of hostnames for additional smart proxy 4. Example [ 'foo4.example.com', 'foo4' ]
#
# $foreman_proxy4_ipaddress:: IP address of additional smart proxy 3. Example: '1.2.3.6'
#
# $manage_packetfilter:: Manage the packet filter. Defaults to false.
class puppetmaster::lcm
(
  String $foreman_db_password,
  String $foreman_admin_firstname,
  String $foreman_admin_lastname,
  String $foreman_admin_email,
  String $foreman_admin_password,
  String $puppetdb_database_password,
  Array[String] $primary_names,
  Boolean $foreman_plugin_cockpit = false,
  Boolean $foreman_compute_vmware = false,
  Boolean $foreman_compute_libvirt = false,
  Boolean $foreman_compute_ec2 = false,
  Boolean $foreman_compute_gce = false,
  Boolean $foreman_compute_openstack = false,
  Boolean $foreman_compute_ovirt = false,
  Boolean $foreman_compute_rackspace = false,
  Boolean $foreman_plugin_azure = false,
  Boolean $foreman_plugin_ansible = false,
  Boolean $foreman_plugin_docker = false,
  Boolean $foreman_plugin_bootdisk = false,
  Boolean $foreman_plugin_default_hostgroup = false,
  Boolean $foreman_plugin_dhcp_browser = false,
  Boolean $foreman_plugin_digitalocean = false,
  Boolean $foreman_plugin_discovery = false,
  Boolean $foreman_plugin_hooks = false,
  Boolean $foreman_plugin_memcache = false,
  Boolean $foreman_plugin_remote_execution = false,
  Boolean $foreman_plugin_tasks = false,
  Boolean $foreman_plugin_templates = false,
  String $foreman_proxy_foreman_base_url = undef,
  Boolean $foreman_proxy_templates = false,
  String $foreman_proxy_templates_listen_on = '',
  Array[String] $foreman_proxy_trusted_hosts = [],
  Boolean $foreman_proxy_dhcp = false,
  String $foreman_proxy_dhcp_listen_on = '',
  Boolean $foreman_proxy_dns = false,
  Boolean $foreman_proxy_dhcp_managed = false,
  String $foreman_proxy_dhcp_interface = '',
  Array[String] $foreman_proxy_dhcp_option_domain = [],
  Array[String] $foreman_proxy_dhcp_search_domains = [],
  String $foreman_proxy_dhcp_server = false,
  String $foreman_proxy_dhcp_provider = false,
  Array[String] $foreman_proxy_dhcp_subnets = [],
  String $foreman_proxy_dhcp_gateway = '',
  String $foreman_proxy_dhcp_range = '',
  String $foreman_proxy_dhcp_nameservers = '',
  String $foreman_proxy_dhcp_pxeserver = '',
  Boolean $foreman_proxy_dns_managed = false,
  Array[String] $foreman_proxy_dns_forwarders = [],
  String $foreman_proxy_dns_interface = '',
  String $foreman_proxy_dns_listen_on = '',
  String $foreman_proxy_dns_provider = '',
  String $foreman_proxy_dns_zone = '',
  String $foreman_proxy_dns_reverse = '',
  String $foreman_proxy_dns_server = '',
  Integer $foreman_proxy_dns_ttl = 8600,
  Boolean $foreman_proxy_tftp = false,
  Boolean $foreman_proxy_tftp_managed = false,
  String $foreman_proxy_tftp_servername = '',
  Boolean $foreman_proxy_tftp_manage_wget = false,
  String $foreman_proxy_tftp_listen_on = '',
  Boolean $foreman_proxy_bmc = false,
  String $foreman_proxy_bmc_listen_on = '',
  Array[String] $foreman_proxy2_hostnames = [],
  String $foreman_proxy2_ipaddress = '',
  Array[String] $foreman_proxy3_hostnames = [],
  String $foreman_proxy3_ipaddress = '',
  Array[String] $foreman_proxy4_hostnames = [],
  String $foreman_proxy4_ipaddress = '',
  String $timezone = 'Etc/UTC',
  Boolean $manage_packetfilter = false,
)
{
  $foreman_version                          = '1.15.6'
  $foreman_repo                             = '1.15'
  $foreman_manage_memcached                 = true
  $foreman_memcached_max_memory             = '8%'
  $foreman_url                              = "https://${facts['fqdn']}"
  $primary_names                            = unique([ "${facts['fqdn']}", "${facts['hostname']}", 'puppet', "puppet.${facts['domain']}" ])
  $foreman_serveraliases                    = $primary_names
  $foreman_puppetdb_dashboard_address       = "http://${facts['fqdn']}:8080/pdb/dashboard"
  $foreman_puppetdb_address                 = "https://${facts['fqdn']}:8081/v2/commands"
  $puppetdb_server                          = $facts['fqdn']
  $foreman_proxy_registered_name            = 'puppet.local'
  $foreman_proxy_repo                       = '1.15'
  $foreman_proxy_version                    = '1.15.6'
  $foreman_proxy_bind_host                  = '0.0.0.0'
  $foreman_proxy_register_in_foreman        = true
  $foreman_proxy_registered_proxy_url       = 'https://puppet.local:8443'
  $foreman_proxy_ensure_packages_version    = 'installed'
  $foreman_proxy_template_url               = 'http://puppet.local:8000'
  $foreman_proxy_manage_sudoersd            = true
  $foreman_proxy_use_sudoers                = true
  $foreman_proxy_use_sudoersd               = true
  # puppet
  $foreman_proxy_puppet                     = true
  $foreman_proxy_autosignfile               = '/etc/puppetlabs/puppet/autosign.conf'
  $foreman_proxy_puppet_url                 = 'https://puppet.local:8140'
  $foreman_proxy_puppet_use_environment_api = true
  $foreman_proxy_puppet_use_cache           = true
  # puppetca settings
  $foreman_proxy_puppetca                   = true
  $foreman_proxy_puppetca_listen_on         = https
  $foreman_proxy_puppetca_cmd               = '/opt/puppetlabs/bin/puppet cert'
  # puppetrun settings
  $foreman_proxy_puppet_listen_on           = https
  $foreman_proxy_puppetrun_cmd              = puppetssh
  $foreman_proxy_puppetrun_provider         = puppetssh
  $foreman_proxy_mcollective_user           = root
  $foreman_proxy_puppetssh_sudo             = true
  $foreman_server_external_nodes            = '/etc/puppetlabs/puppet/node.rb'

  unless ($facts['osfamily'] == 'RedHat' and $facts['os']['release']['major'] == '7') {
    fail("${facts['os']['name']} ${facts['os']['release']['full']} not supported yet")
  }

  # See https://github.com/theforeman/puppet-foreman#foreman-version-compatibility-notes
  if versioncmp($foreman_version, '1.17') < 0 {
    $dynflow_in_core = false
  }
  else {
    $dynflow_in_core = true
  }

  unless $facts['osfamily'] != 'RedHat' {

    class { '::selinux':
      mode => 'enforcing',
      type => 'targeted',
    }

    selinux::module { 'httpd_t':
      ensure    => 'present',
      source_te => '/usr/share/puppetmaster-installer/files/httpd_t.te',
      builder   => 'simple',
    }

    selinux::fcontext { 'set-httpd-file-context':
      seltype  => 'httpd_sys_content_t',
      pathspec => '/etc/puppetlabs/puppet/ssl(/.*)?',
    }

    selinux::exec_restorecon { '/etc/puppetlabs/puppet/ssl':
      require => Selinux::Fcontext['set-httpd-file-context'],
    }
  }

  if ($foreman_manage_memcached) {
    class { 'memcached':
      max_memory => $foreman_memcached_max_memory,
    }
  }

  cron { 'Collect trend data':
    environment => 'PATH=/opt/puppetlabs/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => '/sbin/foreman-rake trends:counter',
    user        => 'root',
    hour        => 0,
    minute      => 0/30,
    require     => Class['::foreman'],
  }

  cron { 'Expire Foreman reports':
    environment => 'PATH=/opt/puppetlabs/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => '/sbin/foreman-rake reports:expire days=30',
    user        => 'root',
    hour        => 2,
    minute      => 0,
    require     => Class['::foreman'],
  }

  cron { 'Expire Foreman not useful=ok reports':
    environment => 'PATH=/opt/puppetlabs/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => '/sbin/foreman-rake reports:expire days=10 status=0',
    user        => 'root',
    hour        => 2,
    minute      => 0,
    require     => Class['::foreman'],
  }

  class { '::epel':
    before => [
      Class['::foreman'],
      Class['::foreman_proxy'],
    ],
  }

  class { '::puppetmaster::puppetdb':
    show_diff                  => true,
    server_foreman             => true,
    autosign                   => '/etc/puppetlabs/puppet/autosign.conf',
    server_reports             => 'store,foreman',
    puppetdb_database_password => $puppetdb_database_password,
    timezone                   => $timezone,
    manage_packetfilter        => $manage_packetfilter,
    server_external_nodes      => $foreman_server_external_nodes,
    before                     => [
      Class['::foreman'],
      Class['::foreman_proxy'],
    ],
  }

  ::puppetmaster::database { 'foreman':
    dbname   => foreman,
    username => foreman,
    password => $foreman_db_password,
    require  => Class['::puppetdb'],
    before   => Class['::foreman'],
  }

  class { '::foreman':
    foreman_url           => $foreman_url,
    db_manage             => false,
    db_username           => 'foreman',
    db_password           => $foreman_db_password,
    db_type               => 'postgresql',
    db_host               => 'localhost',
    db_database           => 'foreman',
    authentication        => true,
    admin_username        => 'admin',
    admin_password        => $foreman_admin_password,
    servername            => 'foreman',
    serveraliases         => $foreman_serveraliases,
    admin_first_name      => $foreman_admin_firstname,
    admin_last_name       => $foreman_admin_lastname,
    admin_email           => $foreman_admin_email,
    organizations_enabled => false,
    initial_organization  => '',
    repo                  => $foreman_repo,
    version               => $foreman_version,
    configure_epel_repo   => false,
    configure_scl_repo    => true,
    locations_enabled     => true,
    initial_location      => 'Foreman Cloud',
    selinux               => true,
    unattended            => true,
    dynflow_in_core       => $dynflow_in_core,
  }

  if $foreman_compute_vmware {
    class { '::foreman::compute::vmware':
    }
  }

  if $foreman_compute_libvirt {
    class { '::foreman::compute::libvirt':
    }
  }

  if $foreman_compute_ec2 {
    class { '::foreman::compute::ec2':
    }
  }

  if $foreman_compute_gce {
    class { '::foreman::compute::gce':
    }
  }

  if $foreman_compute_openstack {
    class { '::foreman::compute::openstack':
    }
  }

  if $foreman_compute_ovirt {
    class { '::foreman::compute::ovirt':
    }
  }

  if $foreman_plugin_azure {
    class { '::foreman::plugin::azure':
    }
  }

  if $foreman_plugin_cockpit {
    class { '::foreman::plugin::cockpit':
    }
  }

  if $foreman_plugin_ansible {

    class { '::foreman::plugin::ansible':
    }

    package { 'ansible':
      ensure  => installed,
      require => Class['::foreman::plugin::ansible'],
    }
  }

  if $foreman_plugin_docker {
    class { '::foreman::plugin::docker':
    }
  }

  if $foreman_plugin_bootdisk {
    class { '::foreman::plugin::bootdisk':
    }
  }

  if $foreman_plugin_default_hostgroup {

    class { '::foreman::plugin::default_hostgroup':
    }

    $default_hostgroup_template = @(END)
---
:default_hostgroup:
  :facts_map:
    "default_linux_group":
      "kernel": "Linux"
    "default_windows_group":
      "kernel": "windows"
    "default_mac_group":
      "kernel": "Darwin"
    "default_other_group":
      "kernel": ".*"
END

    file { '/etc/foreman/plugins/foreman_default_hostgroup.yaml':
      ensure  => file,
      content => inline_epp($default_hostgroup_template),
      require => Class['::foreman::plugin::default_hostgroup'],
    }
  }

  if $foreman_plugin_dhcp_browser {
    class { '::foreman::plugin::dhcp_browser':
    }
  }

  if $foreman_plugin_digitalocean {
    class { '::foreman::plugin::digitalocean':
    }
  }

  if $foreman_plugin_discovery {
    class { '::foreman::plugin::discovery':
    }
  }

  if $foreman_plugin_hooks {
    class { '::foreman::plugin::hooks':
    }
  }

  if $foreman_plugin_memcache {
    class { '::foreman::plugin::memcache':
    }
  }

  if $foreman_plugin_remote_execution {
    class { '::foreman::plugin::remote_execution':
    }
  }

  if $foreman_plugin_tasks {
    class { '::foreman::plugin::tasks':
    }
  }

  if $foreman_plugin_templates {
    class { '::foreman::plugin::templates':
    }
  }

  class { '::foreman::plugin::puppetdb':
    dashboard_address => $foreman_puppetdb_dashboard_address,
    address           => $foreman_puppetdb_address,
  }

  class { '::foreman::cli':
    version            => $foreman_version,
    foreman_url        => $foreman_url,
    username           => 'admin',
    password           => $foreman_admin_password,
    manage_root_config => true,
  }

  if defined(Service['foreman::service']) {
    service { 'foreman::service':
      ensure => running,
    }
  }

  if $manage_packetfilter {

    @firewall { '443 accept template and UI':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => ['80','443'],
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '8443 accept foreman proxies':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '8443',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '8140 allow puppet':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '8140',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '8443 allow traffic to smart proxies':
      chain  => 'OUTPUT',
      state  => ['NEW'],
      dport  => '8443',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '22 accept outgoing foreman-proxy remote ssh execution':
      chain  => 'OUTPUT',
      state  => ['NEW'],
      dport  => '22',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }
  }

  if $foreman_proxy_dns and $manage_packetfilter {

    @firewall { '53 allow incoming dns tcp':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '53',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '53 allow incoming dns udp':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '53',
      proto  => 'udp',
      action => 'accept',
      tag    => default,
    }
  }

  if $foreman_proxy_dhcp and $manage_packetfilter {

    @firewall { '6768 allow dhcp':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => [ '67', '68'],
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }
  }

  if $foreman_proxy_tftp_managed and $manage_packetfilter {

    @firewall { '80 allow kickstart request':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '80',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }

    @firewall { '103 allow incoming tftp':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '69',
      proto  => 'udp',
      action => 'accept',
      tag    => default,
    }
  }

  if $foreman_proxy_templates {

    cron { 'Sync Foreman community templates':
      environment => 'PATH=/opt/puppetlabs/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
      command     => 'foreman-rake templates:sync',
      user        => 'root',
      hour        => '0',
      minute      => '0',
    }
  }

  if $foreman_proxy_templates and $manage_packetfilter {

    @firewall { '8140 allow foreman proxy incoming puppet':
      chain  => 'INPUT',
      state  => ['NEW'],
      dport  => '8140',
      proto  => 'tcp',
      action => 'accept',
      tag    => default,
    }
  }

  class { '::foreman_proxy':
    version                 => $foreman_proxy_version,
    ensure_packages_version => $foreman_proxy_ensure_packages_version,
    repo                    => $foreman_proxy_repo,
    registered_name         => $foreman_proxy_registered_name,
    registered_proxy_url    => $foreman_proxy_registered_proxy_url,
    foreman_base_url        => $foreman_proxy_foreman_base_url,
    trusted_hosts           => $foreman_proxy_trusted_hosts,
    bind_host               => $foreman_proxy_bind_host,
    puppet                  => $foreman_proxy_puppet,
    puppet_use_cache        => $foreman_proxy_puppet_use_cache,
    puppetca                => $foreman_proxy_puppetca,
    puppetca_cmd            => $foreman_proxy_puppetca_cmd,
    tftp                    => $foreman_proxy_tftp,
    tftp_managed            => $foreman_proxy_tftp_managed,
    tftp_manage_wget        => $foreman_proxy_tftp_manage_wget,
    dhcp_managed            => $foreman_proxy_dhcp_managed,
    dhcp                    => $foreman_proxy_dhcp,
    dhcp_listen_on          => $foreman_proxy_dhcp_listen_on,
    dhcp_interface          => $foreman_proxy_dhcp_interface,
    dhcp_subnets            => $foreman_proxy_dhcp_subnets,
    dhcp_gateway            => $foreman_proxy_dhcp_gateway,
    dhcp_range              => $foreman_proxy_dhcp_range,
    dhcp_nameservers        => $foreman_proxy_dhcp_nameservers,
    dhcp_option_domain      => $foreman_proxy_dhcp_option_domain,
    dhcp_search_domains     => $foreman_proxy_dhcp_search_domains,
    dns                     => $foreman_proxy_dns,
    dns_managed             => $foreman_proxy_dns_managed,
    dns_interface           => $foreman_proxy_dns_interface,
    dns_zone                => $foreman_proxy_dns_zone,
    dns_forwarders          => $foreman_proxy_dns_forwarders,
    dns_ttl                 => $foreman_proxy_dns_ttl,
    dns_reverse             => $foreman_proxy_dns_reverse,
    bmc                     => $foreman_proxy_bmc,
    bmc_listen_on           => $foreman_proxy_bmc_listen_on,
    templates               => $foreman_proxy_templates,
    templates_listen_on     => $foreman_proxy_templates_listen_on,
    template_url            => $foreman_proxy_template_url,
    tftp_servername         => $foreman_proxy_tftp_servername,
    manage_sudoersd         => $foreman_proxy_manage_sudoersd,
    use_sudoersd            => $foreman_proxy_use_sudoersd,
    use_sudoers             => $foreman_proxy_use_sudoers,
    register_in_foreman     => $foreman_proxy_register_in_foreman,
    autosignfile            => $foreman_proxy_autosignfile,
  }
}
