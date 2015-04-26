#
class icinga::hostgroup_setup {

  exec { 'hostgroups_build':
    command     => '/usr/local/bin/icinga_build_hostgroups.sh',
    require     => File['icinga-hostgroup-build_command'],
    refreshonly => true,
    notify      => Service['icinga'],
  }

  file { 'icinga-hostgroup-build_dir':
    ensure  => directory,
    path    => $icinga::target::hostgroupsbuilddir,
    recurse => true,
    purge   => true,
#    source  => 'puppet:///icinga/hostgroups/',
    notify  => Exec['hostgroups_build'],
  }

  file { 'icinga-hostgroup-build_command':
    ensure  => present,
    path    => '/usr/local/bin/icinga_build_hostgroups.sh',
    mode    => '0750',
    owner   => 'root',
    group   => 'root',
    content => template('icinga/icinga_build_hostgroups.sh'),
  }

}
