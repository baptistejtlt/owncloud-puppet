#title           :Install.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class called by from owncloud for install.
#author		 :Baptistejtlt
#date            :20160606   
#==============================================================================

class owncloud::install {

    case $::operatingsystem {

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

      'Ubuntu': {
        include ::apt

        if $::lsbdistcodename == 'precise' {
          apt::ppa { 'ppa:ondrej/php5-oldstable':
            before => Package[$::owncloud::package_name],
          }
        }

        apt::source { 'owncloud':
          location => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_${::operatingsystemrelease}/",
          release  => ' ',
          repos    => '/',
          key      => {
            id     => 'F9EA4996747310AE79474F44977C43A8BA684223',
            source => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_${::operatingsystemrelease}/Release.key",
          },
          before   => Package[$::owncloud::package_name],
        }
      }

      'CentOS': {
        include ::epel

        if $::operatingsystemmajrelease == '6' {
          include ::remi
        }

        yumrepo { 'isv:ownCloud:community':
          name     => 'isv_ownCloud_community',
          descr    => "ownCloud Server Version stable (CentOS_${::operatingsystemmajrelease})",
          baseurl  => "https://download.owncloud.org/download/repositories/stable/CentOS_${::operatingsystemmajrelease}/",
          gpgcheck => 1,
          gpgkey   => "https://download.owncloud.org/download/repositories/stable/CentOS_${::operatingsystemmajrelease}/repodata/repomd.xml.key",
          enabled  => 1,
          before   => Package[$::owncloud::package_name],
        }
      }

      'Fedora': {
        yumrepo { 'isv:ownCloud:community':
          name     => 'isv_ownCloud_community',
          descr    => "Latest stable community release of ownCloud (Fedora_${::operatingsystemmajrelease})",
          baseurl  => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Fedora_${::operatingsystemmajrelease}/",
          gpgcheck => 1,
          gpgkey   => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Fedora_${::operatingsystemmajrelease}/repodata/repomd.xml.key",
          enabled  => 1,
          before   => Package[$::owncloud::package_name],
        }
      }



    }
}  
