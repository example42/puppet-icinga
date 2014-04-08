# Define icinga::host_local
#
# Use this to define icinga host objects directly on the Nagios servr
#
# Usage:
# icinga::host_local { "$fqdn": }
#
define icinga::host_local (
  $address       = $name,
  $short_alias   = $name,
  $use           = 'generic-host',
  $host_parent   = '',
  $ensure        = 'present',
  $template      = 'icinga/host_local.erb',
  $hostgroups    = 'all'
  ) {

  file { "${icinga::target::customconfigdir}/hosts/${name}.cfg":
    ensure  => $ensure,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['icinga'],
    content => template( $template ),
  }
}
