# Define icinga::command
#
# Use this to define icinga command objects
#
define icinga::command ( $command_line  = '' ) {

  require icinga

  file { "${icinga::customconfigdir}/commands/${name}.cfg":
    mode    => $icinga::configfile_mode,
    owner   => $icinga::configfile_owner,
    group   => $icinga::configfile_group,
    ensure  => present,
    notify  => Service['icinga'],
    content => template( 'icinga/command.erb' ),
  }

}
