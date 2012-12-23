# Define icinga::hostgroup
#
# Use this to populate hostgroups
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
    path    => "${icinga::target::hostgroupsbuilddir}/${hostgroup},${name}",
    ensure  => $ensure,
    notify  => Exec['hostgroups_build'],
    tag     => "icinga_hostgroup_${icinga::target::magic_tag}",
  }

}
