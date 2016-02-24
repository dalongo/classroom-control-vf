define users::managed_user (
  $home_base = "/home",
  $group     = $title,
){
  File{
    owner => $title,
    group => $group,
    mode => '0640'
  }
  group { $group:
    ensure => present,
  }
  
  user { $title:
    ensure => present,
    gid => $group,
  }
  
  file { "$home_base/$title/.ssh":
    ensure => directory,
    mode => '0700',
  }
}
