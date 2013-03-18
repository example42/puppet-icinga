class icinga::cgi {

  require icinga

  package { 'icinga-gui':
    ensure  => $icinga::manage_package,
    require => Package['icinga'],
  }

  # QUICK AND DIRTY
  file { '/etc/icinga/apache2.conf':
    ensure => link,
    target => $icinga::apache_icingacgi_config,
  }

}
