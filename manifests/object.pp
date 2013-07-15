define icinga::object (
  $host_template   = 'generic-host',
  $hostname        = undef,
  $magic_tag       = undef,
  $magic_hostgroup = undef,
) {
  
  if $name and $name != 'default' {
    $resource_name = "${name}-${::fqdn}"
  } else {
    $resource_name = $::fqdn
  }

  icinga::host { $resource_name:
    hostname => $hostname,
    use => $host_template,
    magic_tag => $magic_tag,
  }

  icinga::baseservices { $resource_name:
    use => 'generic-service',
    magic_tag => $magic_tag,
  }

## TODO Make this work with nagios::plugins
   include icinga::plugins

# Automatic hostgroup management
  if $::icinga_hostgrouplogic {
#    icinga::hostgroup { $resource_name:
#      hostgroup => $magic_hostgroup,
#    }
  }
}
