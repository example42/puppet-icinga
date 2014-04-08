# Define icinga::hostgroup_local
#
define icinga::hostgroup_local (
  $members,
  $alias_name    = $name,
  $ensure        = 'present',
  $template      = 'icinga/hostgroup.erb',
  ) {

  include icinga::target

  file { "${icinga::target::customconfigdir}/hostgroups/${name}.cfg":
    ensure  => $ensure,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['icinga'],
    content => template( $template ),
  }

}
