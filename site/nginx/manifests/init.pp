class nginx {

  package{'nginx':
    ensure=>present,
  }
  
  file {'docroot':
    ensure => directory,
    path   => "???",
  }
  
  file{'index.html':
    ensure => file,
    path   => "/var/www/index.html",
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file{'config':
    ensure  => file,
    path    => "/etc/nginx/nginx.conf",
    source  => 'puppet:///modules/nginx/default.conf',
  }
 
 file{'block':
   ensure  => file,
   path    => "/etc/nginx/conf.d/default.conf',",
   source  => 'puppet:///modules/nginx/default.conf',
   require => Package['nginx'],
   notify  => Service['nginx'],
  ]
  
  service{'nginx':
    ensure  => running,
    require  => File['docroot']
    subscribe => [File['config'],File['block']],
  ]
