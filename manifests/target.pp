#
# Class: icinga::target
#
# Basic host target class
# Include it on nodes to be monitored by icinga
#
# Usage:
# include icinga::target
#
class icinga::target {

  # This variable defines where icinga automatically generated 
  # files are places. This MUST be the same of $::icinga::customconfigdir
  # HINT: Do not mess with default path names...
  $customconfigdir = '/etc/icinga/auto.d'

  # TODO: Find a smarter solution that doesn't requre TopScope Variables
  $magic_tag = get_magicvar($::icinga_grouplogic)

  icinga::host { $fqdn: 
    use => 'generic-host',
  }

  icinga::baseservices { $fqdn:
    use => 'generic-service',
  }

# TODO: Automatic hostgroup management is broken. We'll review it later
#  icinga::hostgroup { "${icinga::params::hostgroups}-$fqdn": 
#    hostgroup => "${icinga::params::hostgroups}",
#  }

}
