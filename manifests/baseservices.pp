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
  $template            = $osfamily ? {
    windows => 'icinga/baseserviceswin.erb',
    default => 'icinga/baseservices.erb',
  },
  $ensure              = 'present'
  ) {

  include icinga::target

  case $::icinga_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat::fragment { "icinga-${host_name}-baseservices":
          target  => "${icinga::target::customconfigdir}/hosts/${host_name}.cfg",
          order   => 02,
          notify  => Service['icinga'],
          content => template( $template ),
          tag     => "icinga_check_${icinga::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_fragment { "icinga-${host_name}+100_baseservices.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${icinga::target::customconfigdir}/services/${host_name}-00-baseservices.cfg":
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
