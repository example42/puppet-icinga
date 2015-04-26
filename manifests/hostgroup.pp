# Define icinga::hostgroup
#
# Use this to populate hostgroups from hosts
# This is an exported resource.
# It should be included on the nodes to be monitored
# but has effects on the icinga server
#
# Usage:
# icinga::hostgroup { $fqdn:
#   hostgroup => $role,
# }
#
define icinga::hostgroup (
  $hostgroup    = 'other',
  $ensure       = 'present',
  ) {

  @@file { "icinga-hostgroup-member-${name}":
    ensure => $ensure,
    path   => "${icinga::target::hostgroupsbuilddir}/${hostgroup},${name}",
    notify => Exec['hostgroups_build'],
    tag    => "icinga_hostgroup_${icinga::target::magic_hostgroup}",
  }

}
