# = Class: icinga
#
# This is the main icinga class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, icinga class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $icinga_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, icinga main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $icinga_source
#
# [*source_dir*]
#   If defined, the whole icinga configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $icinga_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $icinga_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, icinga main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $icinga_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $icinga_options
#
# [*service_autorestart*]
#   Automatically restarts the icinga service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $icinga_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $icinga_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $icinga_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $icinga_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for icinga checks
#   Can be defined also by the (top scope) variables $icinga_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $icinga_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $icinga_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $icinga_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $icinga_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $icinga_audit_only
#   and $audit_only
#
# Default class params - As defined in icinga::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of icinga package
#
# [*service*]
#   The name of icinga service
#
# [*service_status*]
#   If the icinga service init script supports status argument
#
# [*process*]
#   The name of icinga process
#
# [*process_args*]
#   The name of icinga arguments. Used by puppi and monitor.
#   Used only in case the icinga process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user icinga runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include icinga"
# - Call icinga as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class icinga (
  # $grouplogic          = params_lookup( 'grouplogic' ),
  $enable_icingaweb            = params_lookup( 'enable_icingaweb' ),
  $template_icingaweb          = params_lookup( 'template_icingaweb' ),
  $source_dir_icingaweb        = params_lookup( 'source_dir_icingaweb' ),
  $source_dir_purge_icingaweb  = params_lookup( 'source_dir_purge_icingaweb' ),
  $config_dir_icingaweb        = params_lookup( 'config_dir_icingaweb' ),
  $config_file_icingaweb       = params_lookup( 'config_file_icingaweb' ),
  $config_file_mode_icingaweb  = params_lookup( 'config_file_mode_icingaweb' ),
  $config_file_owner_icingaweb = params_lookup( 'config_file_owner_icingaweb' ),
  $config_file_group_icingaweb = params_lookup( 'config_file_group_icingaweb' ),
  $apache_icingaweb_config     = params_lookup( 'apache_icingaweb_config' ),
  $db_host_icingaweb           = params_lookup( 'db_host_icingaweb' ),
  $db_name_icingaweb           = params_lookup( 'db_name_icingaweb' ),
  $db_user_icingaweb           = params_lookup( 'db_user_icingaweb' ),
  $db_password_icingaweb       = params_lookup( 'db_password_icingaweb' ),
  $idoutilspackage             = params_lookup( 'idoutilspackage' ),
  $enable_idoutils             = params_lookup( 'enable_idoutils' ),
  $template_idoutils           = params_lookup( 'template_idoutils' ),
  $db_host_idoutils            = params_lookup( 'db_host_idoutils' ),
  $db_name_idoutils            = params_lookup( 'db_name_idoutils' ),
  $db_user_idoutils            = params_lookup( 'db_user_idoutils' ),
  $db_password_idoutils        = params_lookup( 'db_password_idoutils' ),
  $phpmysql_package            = params_lookup( 'phpmysql_package' ),
  $icingacgipackage            = params_lookup( 'icingacgipackage' ),
  $enable_icingacgi            = params_lookup( 'enable_icingacgi' ),
  $apache_icingacgi_config     = params_lookup( 'apache_icingacgi_config' ),
  $check_external_commands     = params_lookup( 'check_external_commands' ),
  $plugins                     = params_lookup( 'plugins' ),
  $use_ssl                     = params_lookup( 'use_ssl' ),
  $cachedir                    = params_lookup( 'cachedir' ),
  $temp_dir                    = params_lookup( 'temp_dir' ),
  $resourcefile                = params_lookup( 'resourcefile' ),
  $statusfile                  = params_lookup( 'statusfile' ),
  $commandfile                 = params_lookup( 'commandfile' ),
  $resultpath                  = params_lookup( 'resultpath' ),
  $retentionfile               = params_lookup( 'retentionfile' ),
  $p1file                      = params_lookup( 'p1file' ),
  $nrpepluginpackage           = params_lookup( 'nrpepluginpackage' ),
  $htpasswdfile                = params_lookup( 'htpasswdfile' ),
  $template_htpasswdfile       = params_lookup( 'template_htpasswdfile' ),
  $my_class                    = params_lookup( 'my_class' ),
  $source                      = params_lookup( 'source' ),
  $source_dir                  = params_lookup( 'source_dir' ),
  $source_dir_purge            = params_lookup( 'source_dir_purge' ),
  $template                    = params_lookup( 'template' ),
  $service_autorestart         = params_lookup( 'service_autorestart' , 'global' ),
  $options                     = params_lookup( 'options' ),
  $version                     = params_lookup( 'version' ),
  $absent                      = params_lookup( 'absent' ),
  $disable                     = params_lookup( 'disable' ),
  $disableboot                 = params_lookup( 'disableboot' ),
  $monitor                     = params_lookup( 'monitor' , 'global' ),
  $monitor_tool                = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target              = params_lookup( 'monitor_target' , 'global' ),
  $puppi                       = params_lookup( 'puppi' , 'global' ),
  $puppi_helper                = params_lookup( 'puppi_helper' , 'global' ),
  $debug                       = params_lookup( 'debug' , 'global' ),
  $audit_only                  = params_lookup( 'audit_only' , 'global' ),
  $package                     = params_lookup( 'package' ),
  $service                     = params_lookup( 'service' ),
  $service_status              = params_lookup( 'service_status' ),
  $process                     = params_lookup( 'process' ),
  $process_args                = params_lookup( 'process_args' ),
  $process_user                = params_lookup( 'process_user' ),
  $config_dir                  = params_lookup( 'config_dir' ),
  $config_file                 = params_lookup( 'config_file' ),
  $config_file_mode            = params_lookup( 'config_file_mode' ),
  $config_file_owner           = params_lookup( 'config_file_owner' ),
  $config_file_group           = params_lookup( 'config_file_group' ),
  $config_file_init            = params_lookup( 'config_file_init' ),
  $pid_file                    = params_lookup( 'pid_file' ),
  $data_dir                    = params_lookup( 'data_dir' ),
  $log_dir                     = params_lookup( 'log_dir' ),
  $log_file                    = params_lookup( 'log_file' )
  ) inherits icinga::params {

  $bool_enable_icingaweb=any2bool($enable_icingaweb)
  $bool_enable_icingacgi=any2bool($enable_icingacgi)
  $temp_bool_enable_idoutils=any2bool($enable_idoutils)
  $bool_enable_idoutils=$bool_enable_icingaweb ? {
    true  => true,
    false => $temp_bool_enable_idoutils,
  }

  $bool_source_dir_purge_icingaweb=any2bool($source_dir_purge_icingaweb)
  $bool_use_ssl=any2bool($use_ssl)
  $bool_check_external_commands=any2bool($check_external_commands)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $customconfigdir = "${config_dir}/auto.d"

  ### Definition of some variables used in the module
  $manage_package = $icinga::bool_absent ? {
    true  => 'absent',
    false => $icinga::version,
  }

  $manage_service_enable = $icinga::bool_disableboot ? {
    true    => false,
    default => $icinga::bool_disable ? {
      true    => false,
      default => $icinga::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $icinga::bool_disable ? {
    true    => 'stopped',
    default =>  $icinga::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $icinga::bool_service_autorestart ? {
    true    => Service[icinga],
    false   => undef,
  }

  $manage_file = $icinga::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $icinga::bool_absent == true
  or $icinga::bool_disable == true
  or $icinga::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $icinga::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $icinga::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $icinga::source ? {
    ''        => undef,
    default   => $icinga::source,
  }

  $manage_file_content = $icinga::template ? {
    ''        => undef,
    default   => template($icinga::template),
  }

  $manage_file_content_icingaweb = $icinga::template_icingaweb ? {
    ''        => undef,
    default   => template($icinga::template_icingaweb),
  }

  $manage_file_content_idoutils = template($icinga::template_idoutils)

  ### Managed resources
  package { 'nrpe-plugin':
    ensure => $icinga::manage_package,
    name   => $icinga::nrpepluginpackage,
  }

  package { 'icinga':
    ensure => $icinga::manage_package,
    name   => $icinga::package,
  }

  service { 'icinga':
    ensure     => $icinga::manage_service_ensure,
    name       => $icinga::service,
    enable     => $icinga::manage_service_enable,
    hasstatus  => $icinga::service_status,
    pattern    => $icinga::process,
    require    => [ Package['icinga'] , Class['icinga::skel'] ] ,
  }

  file { 'icinga.conf':
    ensure  => $icinga::manage_file,
    path    => $icinga::config_file,
    mode    => $icinga::config_file_mode,
    owner   => $icinga::config_file_owner,
    group   => $icinga::config_file_group,
    require => Package['icinga'],
    notify  => $icinga::manage_service_autorestart,
    source  => $icinga::manage_file_source,
    content => $icinga::manage_file_content,
    replace => $icinga::manage_file_replace,
    audit   => $icinga::manage_audit,
  }

  # The whole icinga configuration directory can be recursively overriden
  if $icinga::source_dir {
    file { 'icinga.dir':
      ensure  => directory,
      path    => $icinga::config_dir,
      require => Package['icinga'],
      notify  => $icinga::manage_service_autorestart,
      source  => $icinga::source_dir,
      recurse => true,
      purge   => $icinga::bool_source_dir_purge,
      replace => $icinga::manage_file_replace,
      audit   => $icinga::manage_audit,
    }
  }

  # Include configuration directories and files
  include icinga::skel
  include icinga::target
  # Collects all the stored configs regarding icinga
  # Host/Service Checks aggregation policy is based on $::icinga_filemode
  case $::icinga_filemode {
    'concat': {
      # One file per host with all the relevant services in auto.d/hosts
      # Concatenated with puppetlabs-concat
      include concat::setup
      Concat <<| tag == "icinga_check_${icinga::target::magic_tag}" |>>
      Concat::Fragment <<| tag == "icinga_check_${icinga::target::magic_tag}" |>>
    }
    'pupmod-concat': {
      # One file per host with all the relevant services in auto.d/hosts
      # Concatenated with onyxpoint-pupmod-concat
      Concat_build <<| tag == "icinga_check_${icinga::target::magic_tag}" |>>
      Concat_fragment <<| tag == "icinga_check_${icinga::target::magic_tag}" |>>
    }
    default: {
      # One file per host auto.d/hosts
      # One file per service auto.d/services
      File <<| tag == "icinga_check_${icinga::target::magic_tag}" |>>
    }
  }

  $magic_hostgroup = get_magicvar($::icinga_hostgrouplogic)
  if $::icinga_hostgrouplogic {
    #include concat::setup
    #Concat <<| tag == "icinga_hostgroup_${icinga::target::magic_tag}" |>>
    #Concat::Fragment <<| tag == "icinga_hostgroup_${icinga::target::magic_tag}" |>>
    include icinga::hostgroup_setup
    File <<| tag == "icinga_hostgroup_${icinga::target::magic_tag}" |>>
  }

  ### Include custom class if $my_class is set
  if $icinga::my_class {
    include $icinga::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $icinga::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'icinga':
      ensure    => $icinga::manage_file,
      variables => $classvars,
      helper    => $icinga::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $icinga::bool_monitor == true {
    monitor::process { 'icinga_process':
      process  => $icinga::process,
      service  => $icinga::service,
      pidfile  => $icinga::pid_file,
      user     => $icinga::process_user,
      argument => $icinga::process_args,
      tool     => $icinga::monitor_tool,
      enable   => $icinga::manage_monitor,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $icinga::bool_debug == true {
    file { 'debug_icinga':
      ensure  => $icinga::manage_file,
      path    => "${settings::vardir}/debug-icinga",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

  ### IDOUTILS Support
  if $icinga::bool_enable_idoutils == true {
    include icinga::idoutils
  }

  ### ICINGAWEB Installation
  if $icinga::bool_enable_icingaweb == true {
    include icinga::web
  }

  ### ICINGACGI Installation
  if $icinga::bool_enable_icingacgi == true {
    include icinga::cgi
  }

  ### Adding www-data to group icinga.
  ### www-data needs permission to icinga.cmd when executing external commands.
  if $::operatingsystem =~ /(?i:Debian|Ubuntu|Mint)/ {
    user { 'www-data':
      groups  => 'nagios',
      require => [ Package['icinga'] ],
    }
  }

}
