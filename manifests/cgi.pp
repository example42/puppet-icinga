class icinga::cgi ( $apache_service = 'apache' ) {
  require icinga

  package { 'icinga-gui':
    ensure  => $icinga::manage_package,
    name    => $icinga::icingacgipackage,
    require => Package['icinga'],
  }

  # QUICK AND DIRTY
  file { $icinga::apache_icingacgi_config:
    ensure => link,
    target => $icinga::apache_icingacgi_target,
    notify => Service[$apache_service]
  }

}
