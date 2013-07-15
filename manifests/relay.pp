
class icinga::relay (
  $magic_tag_target
) {

#  file { [ '/var/lib/puppet/icinga',
#           '/var/lib/puppet/icinga/relay' ]:
#    ensure => directory,
#  }

  file { "/var/lib/puppet/icinga/relay/$::fqdn":
    ensure => directory,
  }

  @@file { "/var/lib/puppet/icinga/relay/$::fqdn/hosts":
    ensure  => directory,
    source  => "file:///${icinga::baseservices::customconfigdir}/hosts/",
    recurse => true,
    require => File['/var/lib/puppet/icinga/relay'],
  }

  @@file { "/var/lib/puppet/icinga/relay/$::fqdn/services":
    ensure  => directory,
    source  => "file:///${icinga::baseservices::customconfigdir}/services/",
    recurse => true,
    require => File['/var/lib/puppet/icinga/relay'],
  }
  

}
