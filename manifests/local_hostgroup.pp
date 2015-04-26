# Define icinga::hostgroup
#
#
define icinga::local_hostgroup (
  $members,
  $alias_name    = $name,
  $ensure        = 'present',
  $template      = 'icinga/hostgroup.erb',
  ) {

  file { "${icinga::target::customconfigdir}/hostgroups/${name}.cfg":
    ensure  => $ensure,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['icinga'],
    content => template( $template ),
  }
}

