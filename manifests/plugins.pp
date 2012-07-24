#
# Class: icinga::plugins
#
# Installs icinga plugins. Needed on hosts with nrpe agent
#
# Usage:
# include icinga::plugins
#
class icinga::plugins {

  # Load the variables used in this module. Check the params.pp file 
  require icinga::params

  # Basic Package 
  package { 'icinga-plugins':
    ensure => present,
    name   => $icinga::params::packagenameplugins,
  }

  # Needed only on the icinga server
  package { 'icinga-plugins-nrpe':
    ensure => present,
    name   => $icinga::params::packagenamenrpeplugin,
  }

  # Include Extra custom Plugins (Provided via Puppet)
  if ( $icinga::params::plugins != 'no') { 
    icinga::plugin { 'check_mount': } 
    icinga::plugin { 'check_ageandcontent.pl': } 
  }

}
