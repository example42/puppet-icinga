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
  $hostname      = undef,
  $ip            = $fqdn,
  $short_alias   = $fqdn,
  $use           = 'generic-host',
  $host_parent   = '',
  $ensure        = 'present',
  $template      = 'icinga/host.erb',
  $hostgroups    = 'all',
  $magic_tag     = undef,
  ) {


  include icinga::object::params

  if $magic_tag {
    $use_magic_tag = $magic_tag
  } else {
    $use_magic_tag = $icinga::object::params::magic_tag
  }

  if $hostname {
    $use_hostname = $hostname
  } else {
    $use_hostname = $name
  }

  $customconfigdir = $icinga::object::params::configdir

  case $::icinga_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat { "${customconfigdir}/hosts/${use_hostname}.cfg":
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          tag     => "icinga_check_${use_magic_tag}",
        }
        @@concat::fragment { "icinga-${use_hostname}":
          target  => "${customconfigdir}/hosts/${name}.cfg",
          order   => 01,
          notify  => Service['icinga'],
          content => template( $template ),
          tag     => "icinga_check_${use_magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_build { "icinga-${::hostname}":
          target => "${customconfigdir}/hosts/${use_hostname}.cfg",
          order  => ['*.tmp'],
        }
        @@concat_fragment { "icinga-${::hostname}+200_${use_hostname}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${customconfigdir}/hosts/${use_hostname}.cfg":
        ensure  => $ensure,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        notify  => Service['icinga'],
        content => template( $template ),
        tag     => "icinga_check_${use_magic_tag}",
      }
    }

  }

}
