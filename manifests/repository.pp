# = Class: icinga::repository
#
# This class configures the repository for Icinga
#
#
class icinga::repository {

  if ( $::icinga::bool_enable_debian_repo_legacy != true and
       $::operatingsystem =~ /(?i:Ubuntu|Mint)/ and
       $::icinga::bool_manage_repos == true
  ) {
    apt::repository {
      'icinga-web':
        url        => 'http://ppa.launchpad.net/formorer/icinga-web/ubuntu',
        distro     => $::lsbdistcodename,
        repository => 'main',
        keyserver  => 'keyserver.ubuntu.com',
        key        => '36862847';
      'icinga':
        url        => 'http://ppa.launchpad.net/formorer/icinga/ubuntu',
        distro     => $::lsbdistcodename,
        repository => 'main',
        keyserver  => 'keyserver.ubuntu.com',
        key        => '36862847';
    }
  }

  if ( $::icinga::bool_enable_debian_repo_legacy == true or
     ($::operatingsystem =~ /(?i:Debian)/ and $::icinga::bool_manage_repos == true)
  ) {
    # Perhaps on Debian we should use the packages from debmon.org
    apt::repository { 'icinga':
      url        => 'http://icingabuild.dus.dg-i.net/',
      distro     => "icinga-web-${::lsbdistcodename}",
      repository => 'main',
    }
  }

}
