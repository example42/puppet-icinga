# Class: icinga::params
#
# This class defines default parameters used by the main module class icinga
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to icinga class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class icinga::params {

  $dependencies_class    = 'icinga::dependencies'

  ### ICINGA-WEB variables
  ####################################################
  $enable_icingaweb = false
  $template_icingaweb = 'icinga/databases.xml.erb'
  $source_dir_icingaweb = ''
  $source_dir_icingaweb_purge = false
  $config_dir_icingaweb = '/etc/icinga-web/conf.d'
  $config_file_icingaweb = '/etc/icinga-web/conf.d/databases.xml'
  $config_file_mode_icingaweb = '0640'
  $config_file_owner_icingaweb = 'root'

  $config_file_group_icingaweb = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/              => 'www-data',
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'apache',
    default                                => 'httpd',
  }

  $apache_icingaweb_config = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/apache2/conf.d/icinga-web.conf',
    default                   => '/etc/httpd/conf.d/icinga-web.conf',
  }

  $apache_icingaweb_target = $::operatingsystem ? {
    default   => '/etc/icinga-web/apache2.conf',
  }

  $db_host_icingaweb = 'localhost'
  $db_name_icingaweb = 'icinga_web'
  $db_user_icingaweb = 'icinga_web'
  $db_password_icingaweb  = 'icinga_web'

  $phpmysql_package = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'php-mysql',
    default                                => 'php5-mysql',
  }
  
  $eventhandler_dir = $::architecture ? {
    'x86_64'  => '/usr/lib64/icinga/eventhandlers',
    default   => '/usr/lib/icinga/eventhandlers'
  }
  
  $config_enable_notifications = true
  $config_obsess_over_services = false

  ## ICINGA IDOUTILS variables
  ####################################################
  $idoutilspackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'icinga-idoutils-libdbi-mysql',
    default                                => 'icinga-idoutils',
  }

  $enable_idoutils = false
  $template_idoutils = 'icinga/ido2db.cfg.erb'
  $db_host_idoutils = 'localhost'
  $db_name_idoutils = 'icinga'
  $db_user_idoutils = 'icinga-idoutils'
  $db_password_idoutils  = 'icinga-idoutils'

  $ido_pid_file = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/run/ido2db.pid',
    default                         => '/var/run/icinga/ido2db.pid',
  }

  $ido_socket_file = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/spool/icinga/ido.sock',
    default                         => '/var/lib/icinga/ido.sock',
  }

  ### ICINGA-CGI variables
  ####################################################
  $icingacgipackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'icinga-gui',
    default                                => 'icinga-cgi',
  }

  $enable_icingacgi = false

  $apache_icingacgi_config = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/apache2/conf.d/icinga.conf',
    default                   => '/etc/httpd/conf.d/icinga.conf',
  }

  $apache_icingacgi_target = $::operatingsystem ? {
    default                   => '/etc/icinga/apache2.conf',
  }

  ### ICINGA variables
  ####################################################
  $grouplogic = ''

  $check_external_commands = true

  $plugins = true

  $use_ssl = true

  $cachedir = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/icinga/',
    default                                => '/var/cache/icinga',
  }

  $temp_dir = $::operatingsystem ? {
    default                                => '/tmp',
  }

  $resourcefile = $::operatingsystem ? {
    default                                => '/etc/icinga/resource.cfg',
  }

  $statusfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/icinga/status.dat',
    default                                => '/var/lib/icinga/status.dat',
  }

  $commandfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/icinga/cmd/icinga.cmd',
    default                                => '/var/lib/icinga/rw/icinga.cmd',
  }

  $resultpath = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/icinga/checkresults',
    default                                => '/var/lib/icinga/spool/checkresults',
  }

  $retentionfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/spool/icinga/retention.dat',
    default                                => '/var/lib/icinga/retention.dat',
  }

  $p1file  = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => $::architecture ? {
      x86_64  => '/usr/lib64/icinga/p1.pl',
      default => '/usr/lib/icinga/p1.pl',
    },
    default                                => '/usr/lib/icinga/p1.pl',
  }

  $template_htpasswdfile = 'icinga/htpasswd'

  $htpasswdfile = $::operatingsystem ? {
    default => '/etc/icinga/htpasswd.users',
  }

  $template_settings_templates   = 'icinga/settings/templates.cfg'
  $template_commands_general     = 'icinga/commands/general.cfg'
  $template_commands_extra       = 'icinga/commands/extra.cfg'
  $template_commands_special     = 'icinga/commands/special.cfg'
  $template_settings_contacts    = 'icinga/settings/contacts.cfg'
  $template_settings_timeperiods = 'icinga/settings/timeperiods.cfg'
  $template_hostgroups_all       = 'icinga/hostgroups/all.cfg'

  ### ICINGA variables
  ####################################################
  $nrpepluginpackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-nrpe',
    default                                => 'nagios-nrpe-plugin',
  }

  $pluginspackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-all',
    default                                => 'nagios-plugins',
  }

  ### Application related parameters

  $package = $::operatingsystem ? {
    default                   => 'icinga',
  }

  $service = $::operatingsystem ? {
    default                   => 'icinga',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default                   => 'icinga',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios',
    default                   => 'icinga',
  }

  $config_dir = $::operatingsystem ? {
    default                   => '/etc/icinga',
  }

  $config_file = $::operatingsystem ? {
    default                   => '/etc/icinga/icinga.cfg',
  }

  $config_file_mode = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '0664',
    default                         => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => 'icinga',
    default                         => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => 'icinga',
    default                         => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/icinga',
    default                   => '/etc/sysconfig/icinga',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/run/icinga.pid',
    default                         => '/var/run/icinga/icinga.pid',
  }

  $data_dir = $::operatingsystem ? {
    default                         => '/var/lib/icinga',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/icinga',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/icinga/icinga.log',
  }

  if $::operatingsystem =~ /(?i:Debian|Ubuntu|Mint)/ {
    $enable_debian_repo_legacy = true
  } else {
    $enable_debian_repo_legacy = false
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'icinga/icinga.cfg.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
