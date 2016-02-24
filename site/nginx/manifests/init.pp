class nginx {

  $nginx_dir = 'puppet:///modules/nginx/'
  
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  package{'nginx':
    ensure=>present,
  }
  
  file {'docroot':
    ensure => directory,
    path   => "/var/www",
  }
  
  file{'index.html':
    ensure => file,
    path   => "/var/www/index.html",
    source => "$(nginx_dir)index.html",
  }
  
  file{'config':
    ensure  => file,
    path    => "/etc/nginx/nginx.conf",
    source  => "($nginx_dir")default.conf",
  }
 
 file{'block':
   ensure  => file,
   path    => "/etc/nginx/conf.d/default.conf',",
   source  => "($nginx_dir")/default.conf',
   require => Package['nginx'],
   notify  => Service['nginx'],
  }
  
  service{'nginx':
    ensure  => running,
    require  => File['docroot'],
    subscribe => [File['config'],File['block']],
  }
}
