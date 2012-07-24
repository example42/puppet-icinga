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

  $grouplogic = ''

  $check_external_commands = true

  $plugins = true

  $use_ssl = true

  $cachedir = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/icinga',
    default                                => '/var/cache/icinga',
  }

  $resourcefile = $::operatingsystem ? {
    default                                => '/etc/icinga/resource.cfg',
  }

  $statusfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/icinga/status.dat',
    default                                => '/var/lib/icinga/status.dat',
  }

  $commandfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/icinga/rw/icinga.cmd',
    default                                => '/var/lib/icinga/rw/icinga.cmd',
  }

  $resultpath = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/icinga/retention.dat',
    default                                => '/var/lib/icinga/spool/checkresults',
  }

  $retentionfile = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => '/var/icinga/retention.dat',
    default                                => '/var/lib/icinga/retention.dat',
  }

  $p1file  = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => $::architecture ? {
      x86_64  => '/usr/lib64/icinga/p1.pl',
      default => '/usr/lib/icinga/p1.pl',
    },
    default                                => '/usr/lib/icinga/p1.pl',
  }

  $nrpepluginpackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-nrpe',
    default                                => 'nagios-nrpe-plugin',
  }

  $pluginspackage = $::operatingsystem ? {
    /(?i:RedHat|Centos|Scientific|Fedora)/ => 'nagios-plugins-all',
    default                                => 'nagios-plugins',
  }

  $htpasswdfile = $::operatingsystem ? {
    default => '/etc/icinga/htpasswd.users',
  }


  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'icinga',
  }

  $service = $::operatingsystem ? {
    default => 'icinga',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'icinga',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'nagios',
    default                   => 'icinga',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/icinga',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/icinga/icinga.cfg',
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
    /(?i:RedHat|Scientific|Centos)/ => '/var/icinga/icinga.pid',
    default                         => '/var/run/icinga/icinga.pid',
  }

  $data_dir = $::operatingsystem ? {
    /(?i:RedHat|Scientific|Centos)/ => '/var/icinga', 
    default                         => '/var/lib/icinga',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/icinga',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/icinga/icinga.log',
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
