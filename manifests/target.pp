#
# Class: icinga::target
#
# Basic host target class
# Include it on nodes to be monitored by icinga
#
# Usage:
# include icinga::target
#
class icinga::target (
  $host_template = 'generic-host'
  ) {

  # This variable defines where icinga automatically generated 
  # files are places. This MUST be the same of $::icinga::customconfigdir
  # HINT: Do not mess with default path names...

  $customconfigdir = $::icinga_customconfigdir ? {
    ''      => '/etc/icinga/auto.d',
    default => $::icinga_customconfigdir,
  }

  $hostgroupsbuilddir = '/etc/icinga/hostgroups_build'

  # TODO: Find a smarter solution that doesn't require TopScope Variables
  $magic_tag = get_magicvar($::icinga_grouplogic)

  # TODO: Find a smarter solution that doesn't require TopScope Variables
  $magic_hostgroup = get_magicvar($::icinga_hostgrouplogic)

  icinga::host { $fqdn: 
    use => $host_template,
  }

  icinga::baseservices { $fqdn:
    use => 'generic-service',
  }

## TODO Make this work with nagios::plugins
#   include icinga::plugins

# Automatic hostgroup management
  if $::icinga_hostgrouplogic {
    icinga::hostgroup { $fqdn: 
      hostgroup => $magic_hostgroup,
    }
  }
}
