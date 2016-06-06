#title           :Install.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class called by from owncloud for install.
#author		 :Baptistejtlt
#date            :20160606   
#==============================================================================

class owncloud::install {
      'Debian': {
        include ::apt
        apt::source { 'owncloud':
          location => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_${::operatingsystemmajrelease}.0/",
          release  => ' ',
          repos    => '/',
          key      => {
            id     => 'F9EA4996747310AE79474F44977C43A8BA684223',
            source => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_${::operatingsystemmajrelease}.0/Release.key",
          },
          before   => Package[$::owncloud::package_name],
        }
}
  package { $::owncloud::package_name:
    ensure => present,
}
