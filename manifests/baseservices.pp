# Define icinga::baseservices
#
# Use this to define Nagios basic service objects that will be
# used for to all nodes
# All local disks, memory, cpu, local users...
# It's automatically loaded in icinga::target
#
# This is an exported resource.
#
define icinga::baseservices (
  $host_name           = $fqdn,
  $service_description = '',
  $use                 = 'generic-service',
  $template            = 'icinga/baseservices.erb',
  $ensure              = 'present',
  $magic_tag           = undef,
  ) {

  include icinga::object::params

  $customconfigdir = $icinga::object::params::configdir

  if $magic_tag {
    $use_magic_tag = $magic_tag
  } else {
    $use_magic_tag = $icinga::object::params::magic_tag
  }

  case $::icinga_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat::fragment { "icinga-${name}-baseservices":
          target  => "${customconfigdir}/hosts/${name}.cfg",
          order   => 02,
          notify  => Service['icinga'],
          content => template( $template ),
          tag     => "icinga_check_${icinga::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_fragment { "icinga-${name}+100_baseservices.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${customconfigdir}/services/${name}-00-baseservices.cfg":
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
