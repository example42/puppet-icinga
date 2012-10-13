# Define: icinga::plugin
#
# Adds a custom icinga plugin
#
# Usage:
# With standard source (looked in icing/files/icinga-plugins/$name):
# icinga::plugin { 'check_mount': }
#
# With custom source (looked in source => $source)
# icinga::plugin { 'check_orientdb':
#   source => 'orientdb/nagios-plugins/check_orientdb.sh'
# }
define icinga::plugin (
  $source = '',
  $enable = true
  ) {

  include icinga::params
  include nrpe::params

  $ensure = bool2ensure( $enable )

  $real_source = $source ? {
    ''      => "icinga/icinga-plugins/${name}",
    default => $source,
  }

  file { "icinga_plugin_${name}":
    path    => "${nrpe::params::pluginsdir}/${name}",
    owner   => root,
    group   => root,
    mode    => 0755,
    ensure  => $ensure,
    source  => "puppet:///modules/${source}",
    require => Package['icinga-plugins'],
  }

}
