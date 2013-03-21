# Class icinga::idoutils
#
# This class installs idoutils
# It's automatically loaded if $enable_idoutils is set to true
#
class icinga::idoutils {

  require icinga

  package { 'icinga-idoutils':
    ensure => $icinga::manage_package,
    name   => $icinga::idoutilspackage,
  }

  service { 'ido2db':
    ensure     => $icinga::manage_service_ensure,
    enable     => $icinga::manage_service_enable,
    hasstatus  => $icinga::service_status,
    require    => [ Package['icinga-idoutils'] ] ,
  }

  file { 'ido2db.cfg':
    ensure  => $icinga::manage_file,
    path    => "${icinga::config_dir}/ido2db.cfg",
    mode    => '0600',
    owner   => $icinga::process_user,
    group   => $icinga::process_user,
    require => Package['icinga-idoutils'],
    notify  => Service['ido2db'],
    content => $icinga::manage_file_content_idoutils,
    replace => $icinga::manage_file_replace,
    audit   => $icinga::manage_audit,
  }


  # Grants Management (Currently only Mysql backend is supported)
  case $icinga::db_host_idoutils {
    'localhost','127.0.0.1': {
      mysql::grant { "icinga_server_grants_${::fqdn}":
        mysql_db         => $icinga::db_name_idoutils,
        mysql_user       => $icinga::db_user_idoutils,
        mysql_password   => $icinga::db_password_idoutils,
        mysql_privileges => 'ALL',
        mysql_host       => $icinga::db_host_idoutils,
      }
    }
    default: {
      # Automanagement of Mysql grants on external servers
      # requires StoredConfigs.
      @@mysql::grant { "icinga_server_grants_${::fqdn}":
        mysql_db         => $icinga::db_name_idoutils,
        mysql_user       => $icinga::db_user_idoutils,
        mysql_password   => $icinga::db_password_idoutils,
        mysql_privileges => 'ALL',
        mysql_host       => $::fqdn,
        tag              => "mysql_grants_${icinga::db_host_idoutils}",
      }
    }
  }

}
