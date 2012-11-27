class icinga::web {

  require icinga::idoutils

  package { 'icinga-web':
    ensure => $icinga::manage_package,
  }

  # QUICK AND DIRTY
  file { '/etc/apache2/conf.d/icinga-web.conf':
    ensure => '/etc/icinga-web/apache2.conf',
  }

  if $::operatingsystem =~ /(?i:Debian|Ubuntu|Mint)/ {
    apt::repository { 'icinga':
      url        => 'http://icingabuild.dus.dg-i.net/',
      distro     => "icinga-web-${lsbdistcodename}",
      repository => 'main',
    }
  }

  file { 'icingaweb.conf':
    ensure  => $icinga::manage_file,
    path    => $icinga::config_file_icingaweb,
    mode    => $icinga::config_file_mode_icingaweb,
    owner   => $icinga::config_file_owner_icingaweb,
    group   => $icinga::config_file_group_icingaweb,
    require => Package['icinga-web'],
#    notify  => $icinga::manage_service_autorestart,
    content => $icinga::manage_file_content_icingaweb,
    replace => $icinga::manage_file_replace,
    audit   => $icinga::manage_audit,
  }

  # The whole icinga-web configuration directory can be recursively overriden
  if $icinga::source_dir_icingaweb {
    file { 'icingaweb.dir':
      ensure  => directory,
      path    => $icinga::config_dir_icingaweb,
      require => Package['icinga-web'],
#      notify  => $icinga::manage_service_autorestart,
      source  => $icinga::source_dir_icingaweb,
      recurse => true,
      ignore  => '.svn',
      purge   => $icinga::bool_source_dir_purge_icingaweb,
      replace => $icinga::manage_file_replace,
      audit   => $icinga::manage_audit,
    }
  }


  # Grants Management (Currently only Mysql backend is supported)
  case $icinga::db_host_icingaweb {
    'localhost','127.0.0.1': {
      mysql::grant { "icinga_web_grants_${::fqdn}":
        mysql_db         => $icinga::db_name_icingaweb,
        mysql_user       => $icinga::db_user_icingaweb,
        mysql_password   => $icinga::db_password_icingaweb,
        mysql_privileges => 'ALL',
        mysql_host       => $icinga::db_host_icingaweb,
      }
    }
    default: {
      # Automanagement of Mysql grants on external servers
      # requires StoredConfigs.
      @@mysql::grant { "icinga_web_grants_${::fqdn}":
        mysql_db         => $icinga::db_name_icingaweb,
        mysql_user       => $icinga::db_user_icingaweb,
        mysql_password   => $icinga::db_password_icingaweb,
        mysql_privileges => 'ALL',
        mysql_host       => $::fqdn,
        tag              => "mysql_grants_${icinga::db_host_icingaweb}",
      }
    }
  }

}
