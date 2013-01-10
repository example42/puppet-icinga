# Define icinga::command
#
# Use this to define icinga command objects
#
define icinga::command ( $command_line  = '' , $ensure => 'present' ) {

  require icinga

  file { "${icinga::customconfigdir}/commands/${name}.cfg":
    ensure  => $ensure,
    mode    => $icinga::config_file_mode,
    owner   => $icinga::config_file_owner,
    group   => $icinga::config_file_group,
    notify  => Service['icinga'],
    content => template( 'icinga/command.erb' ),
  }

}
