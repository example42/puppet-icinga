# Define: pagios::plugin
#
# Adds a custom icinga plugin
#
# Usage:
# With standard source (looked in icing/files/icinga-plugins/$name):
# icinga::plugin { 'check_mount': }
#
# With custom source (looked in source => $source)
# icinga::plugin { 'check_orientdb':
#   source => 'orientdb/icinga-plugins/check_orientdb.sh'
# }
define icinga::plugin (
  $source = '',
  $nrpe_cfg = '',
  $enable = true
  ) {

  include nrpe

  $ensure = bool2ensure( $enable )

  $real_source = $source ? {
    ''      => "icinga/icinga-plugins/${name}",
    default => $source,
  }

  if ( $source != 'no' ) {
    file { "icinga_plugin_${name}":
      ensure  => $ensure,
      path    => "${nrpe::pluginsdir}/${name}",
      owner   => root,
      group   => root,
      mode    => '0755',
      source  => "puppet:///modules/${real_source}",
      require => Class['nrpe'],
    }
  }

  if ( $nrpe_cfg != '' ) {
    file { "nrpe_icinga_plugin_${name}":
      ensure  => $ensure,
      path    => "${nrpe::config_dir}/${name}.cfg",
      owner   => root,
      group   => root,
      mode    => '0755',
      notify  => $nrpe::manage_service_autorestart,
      content => template($nrpe_cfg),
    }
  }
}
