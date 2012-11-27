class icinga::hostgroup_setup {

  exec { 'hostgroups_build':
    command     => '/usr/local/bin/icinga_build_hostgroups.sh',
    require     => File['icinga-hostgroup-build_command'],
    refreshonly => true,
    notify      => Service['icinga'],
  }

  file { 'icinga-hostgroup-build_dir':
    path    => $icinga::target::hostgroupsbuilddir,
    ensure  => directory,
    purge   => true,
  }

  file { 'icinga-hostgroup-build_command':
    path    => '/usr/local/bin/icinga_build_hostgroups.sh',
    ensure  => present,
    mode    => 0750,
    owner   => 'root',
    group   => 'root',
    content => template('icinga/icinga_build_hostgroups.sh'),
  }


}
