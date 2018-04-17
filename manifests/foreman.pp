class puppetmaster::foreman
(
  $foreman_db_manage,
  $foreman_db_type,
  $foreman_db_host,
  $foreman_db_database,
  $foreman_db_username,
  $foreman_db_password,
  $foreman_connection_limit,
  $foreman_authentication,
  $foreman_servername,
  $foreman_serveraliases,
  $foreman_admin_first_name,
  $foreman_admin_last_name,
  $foreman_admin_email,
  $foreman_organizations_enabled,
  $foreman_initial_organization,
  $foreman_locations_enabled,
  $foreman_initial_location,
  $foreman_admin_username,
  $foreman_admin_password,
  $foreman_puppetdb_dashboard_address,
  $foreman_puppetdb_address,
  $foreman_foreman_url,
  $foreman_repo,
  $foreman_version,
  $foreman_manage_memcached,
  $foreman_memcached_max_memory,
  $foreman_configure_epel_repo,
  $foreman_configure_scl_repo,
  $foreman_oauth_consumer_key,
  $foreman_oauth_consumer_secret,
  $foreman_selinux,
  $foreman_unattended,
  $foreman_plugin_cockpit,
  $foreman_compute_vmware,
  $foreman_compute_libvirt,
  $foreman_compute_ec2,
  $foreman_compute_gce,
  $foreman_compute_openstack,
  $foreman_compute_ovirt,
  $foreman_compute_rackspace,
  $foreman_plugin_ansible,
  $foreman_plugin_docker,
  $foreman_plugin_bootdisk,
  $foreman_plugin_default_hostgroup,
  $foreman_plugin_dhcp_browser,
  $foreman_plugin_digitalocean,
  $foreman_plugin_discovery,
  $foreman_plugin_hooks,
  $foreman_plugin_memcache,
  $foreman_plugin_remote_execution,
  $foreman_plugin_tasks,
  $foreman_plugin_templates,
)
{
  # See https://github.com/theforeman/puppet-foreman#foreman-version-compatibility-notes
  if versioncmp($foreman_version, '1.16') <= 0 {
    $dynflow_in_core = false
  }
  else {
    $dynflow_in_core = true
  }

  firewall { '443 accept incoming foreman template and UI':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => ['80','443'],
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '8443 accept incoming foreman proxy':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '8443',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '8140 allow incoming puppet':
    chain  => 'INPUT',
    state  => ['NEW'],
    dport  => '8140',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '8443 allow outgoing traffic to smart proxies':
    chain  => 'OUTPUT',
    state  => ['NEW'],
    dport  => '8443',
    proto  => 'tcp',
    action => 'accept',
  }

  if ! $foreman_db_manage {

    ::postgresql::server::role { $foreman_db_username:
      password_hash    => postgresql_password($foreman_db_username, $foreman_db_password),
      connection_limit => $foreman_db_connection_limit,
    }

    ::postgresql::server::database_grant { "Grant all to $foreman_db_username":
      privilege => 'ALL',
      db        => $foreman_db_database,
      role      => $foreman_db_username,
    }

    ::postgresql::server::db { $foreman_db_database:
      user     => $foreman_db_username,
      password => postgresql_password($foreman_db_username, $foreman_db_password),
    }

  }

  if ($foreman_manage_memcached) {
    class { 'memcached':
      max_memory => "$foreman_memcached_max_memory",
    }
  }

  cron { 'Collect trend data':
    environment => 'PATH=/opt/puppetlabs/bin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => '/sbin/foreman-rake foreman-rake trends:counter',
    user        => 'root',
    hour        => 0,
    minute      => 0/30,
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

  class { '::foreman':
    foreman_url           => $foreman_foreman_url,
    db_manage             => $foreman_db_manage,
    db_username           => $foreman_db_username,
    db_password           => $foreman_db_password,
    db_type               => $foreman_db_type,
    db_host               => $foreman_db_host,
    db_database           => $foreman_db_database,
    authentication        => $foreman_authentication,
    admin_username        => $foreman_admin_username,
    admin_password        => $foreman_admin_password,
    servername            => $foreman_servername,
    serveraliases         => $foreman_serveraliases,
    admin_first_name      => $foreman_admin_first_name,
    admin_last_name       => $foreman_admin_last_name,
    admin_email           => $foreman_admin_email,
    organizations_enabled => $foreman_organizations_enabled,
    initial_organization  => $foreman_initial_organization,
    repo                  => $foreman_repo,
    version               => $foreman_version,
    configure_epel_repo   => $foreman_configure_epel_repo,
    configure_scl_repo    => $foreman_configure_scl_repo,
    oauth_consumer_key    => $foreman_oauth_consumer_key,
    oauth_consumer_secret => $foreman_oauth_consumer_secret,
    locations_enabled     => $foreman_locations_enabled,
    initial_location      => $foreman_initial_location,
    selinux               => $foreman_selinux,
    unattended            => $foreman_unattended,
    dynflow_in_core       => $dynflow_in_core,
  }

  if $foreman_compute_vmware {
    include ::foreman::compute::vmware
  }

  if $foreman_compute_libvirt {
    include ::foreman::compute::libvirt
  }

  if $foreman_compute_ec2 {
    include ::foreman::compute::ec2
  }

  if $foreman_compute_gce {
    include ::foreman::compute::gce
  }

  if $foreman_compute_openstack {
    include ::foreman::compute::openstack
  }

  if $foreman_compute_ovirt {
    include ::foreman::compute::ovirt
  }

  if $foreman_plugin_cockpit {
    include ::foreman::plugin::cockpit
  }

  if $foreman_plugin_ansible {

    include ::foreman::plugin::ansible

    package { 'ansible':
      ensure  => installed,
      require => Class['::foreman::plugin::ansible'],
    }
  }

  if $foreman_plugin_docker {
    include ::foreman::plugin::docker
  }

  if $foreman_plugin_bootdisk {
    include ::foreman::plugin::bootdisk
  }

  if $foreman_plugin_default_hostgroup {

    include ::foreman::plugin::default_hostgroup
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
    include ::foreman::plugin::dhcp_browser
  }

  if $foreman_plugin_digitalocean {
    include ::foreman::plugin::digitalocean
  }

  if $foreman_plugin_discovery {
    include ::foreman::plugin::discovery
  }

  if $foreman_plugin_hooks {
    include ::foreman::plugin::hooks
  }

  if $foreman_plugin_memcache {
    include ::foreman::plugin::memcache
  }

  if $foreman_plugin_remote_execution {
    include ::foreman::plugin::remote_execution
  }

  if $foreman_plugin_tasks {
    include ::foreman::plugin::tasks
  }

  if $foreman_plugin_templates {
    include ::foreman::plugin::templates
  }

  class { '::foreman::plugin::puppetdb':
    dashboard_address => $foreman_puppetdb_dashboard_address,
    address           => $foreman_puppetdb_address,
  }

  class { '::foreman::cli':
    foreman_url        => $foreman_foreman_url,
    username           => 'admin',
    password           => $foreman_admin_password,
    manage_root_config => true,
  }
}