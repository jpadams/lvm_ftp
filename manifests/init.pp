class lvm_ftp (
  $package_name = 'vsftpd',
  $service_name = 'vsftpd',
  $confdir      = '/etc',
  $lvm_url      = 'http://d211c3u0z4tqwj.cloudfront.net/puppet-2015.3.1-learning-3.2.ova',
  ) {
  package { $package_name: ensure => installed, }

  service { $service_name:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package[$package_name],
  }

  file { "${confdir}/vsftpd.conf":
    content => template('lvm_ftp/vsftpd.conf.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  exec { "/usr/bin/wget ${lvm_url} -O /srv/ftp/puppet-2015.3.1-learning-3.2.ova":
    creates => '/srv/ftp/puppet-2015.3.1-learning-3.2.ova',
    require => Package[$package_name],
  }
}
