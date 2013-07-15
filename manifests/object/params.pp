
class icinga::object::params (
  $customconfigdir  = undef,
  $custom_magic_tag = undef,
  $custom_magic_hostgroup = undef,
) {
  
  
  # This variable defines where icinga automatically generated
  # files are places. This MUST be the same of $::icinga::customconfigdir
  # HINT: Do not mess with default path names...
  
  if $customconfigdir {
    $configdir = $customconfigdir
  } else {
    $configdir = $::icinga_customconfigdir ? {
      ''      => '/etc/icinga/auto.d',
      default => $::icinga_customconfigdir,
    }
  }
  
  if $custom_magic_tag {
    $magic_tag = $custom_magic_tag
  } else {
      # TODO: Find a smarter solution that doesn't require TopScope Variables
    $magic_tag = get_magicvar($::icinga_grouplogic)
  }
  
  if $custom_magic_hostgroup {
    $magic_hostgroup = $custom_magic_hostgroup
  } else {
      # TODO: Find a smarter solution that doesn't require TopScope Variables
    $magic_hostgroup = get_magicvar($::icinga_hostgrouplogic)
  }
  

}
