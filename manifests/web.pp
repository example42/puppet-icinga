# = Class: icinga::web
#
# This class provides the Icinga-web functionality
#
# Rather than invoking this class directly, it should be invoked
# via the main Icinga class. Generally, you should enable idoutils
# for icinga-web to function.
#
# = Examples:
#
#  class { '::icinga':
#    puppi                     => true,
#    enable_idoutils           => true,
#    enable_icingaweb          => true,
#    enable_debian_repo_legacy => false,
#    manage_repos              => true,
#  }
#
#
class icinga::web {

  require icinga::idoutils

  package { 'icinga-web':
    ensure  => $icinga::manage_package,
    require => Class['icinga::repository'],
  }

  package { 'php-mysql':
    ensure => $icinga::manage_package,
    name   => $icinga::phpmysql_package,
  }
    
  file { $icinga::apache_icingaweb_config:
    ensure  => present,
    notify  => Service['apache'],
    require => Package['icinga-web'],
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

  # The whole icinga-web configuration directory can be overriden recursively
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

      if $::operatingsystem =~ /(?i:Ubuntu|Mint)/ {
        mysql::queryfile { 'icinga_web':
          mysql_file     => '/usr/share/dbconfig-common/data/icinga-web/install/mysql',
          mysql_db       => $icinga::db_name_icingaweb,
          mysql_user     => $icinga::db_user_icingaweb,
          mysql_password => $icinga::db_password_icingaweb,
          require        => Mysql::Grant["icinga_web_grants_${::fqdn}"]
        }
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

      if $::operatingsystem =~ /(?i:Ubuntu|Mint)/ {
        @@mysql::queryfile { "icinga_web_${::fqdn}":
          mysql_file     => '/usr/share/dbconfig-common/data/icinga-web/install/mysql',
          mysql_db       => $icinga::db_name_icingaweb,
          mysql_user     => $icinga::db_user_icingaweb,
          mysql_password => $icinga::db_password_icingaweb,
          mysql_host     => $::fqdn,
          tag            => "mysql_grants_${icinga::db_host_icingaweb}",
          require        => Mysql::Grant["icinga_web_grants_${::fqdn}"]
        }
      }

    }
  }

}
