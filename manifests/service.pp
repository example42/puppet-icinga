# Define icinga::service
#
# Use this to define icinga service objects
# This is an exported resource.
# It should be included on the nodes to be monitored but
# has effects on the icinga server
# You can decide what method to use to create resources on the
# icinga server with the $::icinga_filemode top scope variable
# NOTE: THIS MUST BE the same for all nodes
#
define icinga::service (
  $host_name           = $fqdn,
  $check_command       = '',
  $service_description = '',
  $use                 = 'generic-service',
  $template            = 'icinga/service.erb',
  $ensure              = 'present'
  ) {

  # Autoinclude the target host class
  # (each service must have a defined host)
  include icinga::target

  # Set defaults based on the same define $name
  $real_check_command = $check_command ? {
    ''      => $name,
    default => $check_command,
  }

  $real_service_description = $service_description ? {
    ''      => $name,
    default => $service_description,
  }

  case $::icinga_filemode {

    'concat': {
      if $ensure == 'present' {
        @@concat::fragment { "icinga-${host_name}-${name}":
          target  => "${icinga::target::customconfigdir}/hosts/${host_name}.cfg",
          order   => 05,
          notify  => Service['icinga'],
          content => template( $template ),
          tag     => "icinga_check_${icinga::target::magic_tag}",
        }
      }
    }

    'pupmod-concat': {
      if $ensure == 'present' {
        @@concat_fragment { "icinga-${host_name}+200_${name}.tmp":
          content => template( $template ),
        }
      }
    }

    default: {
      @@file { "${icinga::target::customconfigdir}/services/${host_name}-${name}.cfg":
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
