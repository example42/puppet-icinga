# Define icinga::service_local
#
# Use this to define icinga service objects directly on the Nagios server
#
define icinga::service_local (
  $host_name           = $fqdn,
  $check_command       = '',
  $service_description = '',
  $use                 = 'generic-service',
  $template            = 'icinga/service.erb',
  $ensure              = 'present'
  ) {

  $real_check_command = $check_command ? {
    ''      => $name,
    default => $check_command,
  }

  $real_service_description = $service_description ? {
    ''      => $name,
    default => $service_description,
  }

  file { "${icinga::target::customconfigdir}/services/${host_name}-${name}.cfg":
    ensure  => $ensure,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['icinga'],
    content => template( $template ),
  }

}
