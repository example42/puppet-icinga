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
  $host_template = 'generic-host',
) inherits icinga::object::params {


  icinga::object { 'default':
    magic_tag       => $magic_tag,
    magic_hostgroup => $magic_hostgroup,
  }

  $hostgroupsbuilddir = '/etc/icinga/hostgroups_build'

}

