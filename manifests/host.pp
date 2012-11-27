# Define icinga::host
#
# Use this to define icinga host objects
# This is an exported resource.
# It should be included on the nodes to be monitored
# but has effects on the icinga server
# You can decide what method to use to create resources on the
# icinga server with the $::icinga_filemode top scope variable
# NOTE: THIS MUST BE the same for all nodes
#
# Usage:
# icinga::host { "$fqdn": }
#
define icinga::host (
  $ip            = $fqdn,
  $short_alias   = $fqdn,
  $use           = 'generic-host',
  $host_parent   = '',
  $ensure        = 'present',
  $template      = 'icinga/host.erb',
  $hostgroups    = 'all'
  ) {

  include icinga::target

  case $::icinga_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat { "${icinga::target::customconfigdir}/hosts/${name}.cfg":
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          tag     => "icinga_check_${icinga::target::magic_tag}",
        }
        @@concat::fragment { "icinga-${name}":
          target  => "${icinga::target::customconfigdir}/hosts/${name}.cfg",
          order   => 01,
          notify  => Service['icinga'],
          content => template( $template ),
          tag     => "icinga_check_${icinga::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_build { "icinga-${::hostname}":
          target => "${icinga::target::customconfigdir}/hosts/${name}.cfg",
          order  => ['*.tmp'],
        }
        @@concat_fragment { "icinga-${::hostname}+200_${name}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${icinga::target::customconfigdir}/hosts/${name}.cfg":
        ensure  => $ensure,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        notify  => Service['icinga'],
        content => template( $template ),
        tag     => "icinga_check_${icinga::target::magic_tag}",
      }
    }

  }

}
