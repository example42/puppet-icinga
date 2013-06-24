# Class: icinga::dependencies
#
# This class installs icinga dependencies
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by default in icinga by the parameter
# dependencies_class. You may provide an alternative class name to
# provide the same resources (eventually not using Example42 modules)
#
class icinga::dependencies {

  include icinga

  # Both the traditional Icinga as well as Icinga-Web gui's utilize
  # Apache Http to serve their frontend. Even if the packaging provide
  # Apache Http as a dependency, including this package ensures it can
  # also be monitored.
  if $icinga::manage_package {
    include ::apache
  }

  include ::icinga::repository

}
