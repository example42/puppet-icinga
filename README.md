# Puppet module: icinga

This is a Puppet module for icinga based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-icinga

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install icinga with default settings

        class { 'icinga': }

* Install a specific version of icinga package

        class { 'icinga':
          version => '1.0.1',
        }

* Disable icinga service.

        class { 'icinga':
          disable => true
        }

* Remove icinga package

        class { 'icinga':
          absent => true
        }

* Enable auditing without without making changes on existing icinga configuration files

        class { 'icinga':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'icinga':
          source => [ "puppet:///modules/lab42/icinga/icinga.conf-${hostname}" , "puppet:///modules/lab42/icinga/icinga.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'icinga':
          source_dir       => 'puppet:///modules/lab42/icinga/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'icinga':
          template => 'example42/icinga/icinga.conf.erb',
        }

* Automatically include a custom subclass

        class { 'icinga':
          my_class => 'icinga::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'icinga':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'icinga':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'icinga':
          monitor      => true,
          monitor_tool => [ 'icinga' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'icinga':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/example42/puppet-icinga.png?branch=master)](https://travis-ci.org/example42/puppet-icinga)
