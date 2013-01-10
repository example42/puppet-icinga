#
# Class: icinga::plugins
#
# Installs Nagios custom plugins used in Example42 modules
#
# Usage:
# include icinga::plugins
#
class icinga::plugins {

  # Include Extra custom Plugins (Provided via Puppet)
  icinga::plugin { 'check_mount': }
  icinga::plugin { 'check_disks':
    source   => 'no' ,
    nrpe_cfg => 'icinga/nrpe_cfg/nrpe-check_disk.cfg.erb',
  }
  icinga::plugin { 'check_yum':
    nrpe_cfg => 'icinga/nrpe_cfg/nrpe-check_yum.cfg.erb',
  }
  icinga::plugin { 'check_ageandcontent.pl': }

}
