#title           :Params.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class definition to set variables.
#author		 :Baptistejtlt
#date            :20160608   
#==============================================================================

class owncloud::params {
  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Debian', 'Ubuntu': {
          $datadirectory = '/var/www/owncloud/data'
          $documentroot  = '/var/www/owncloud'
          $package_name  = 'owncloud-server'
          $www_user      = 'www-data'
          $www_group     = 'www-data'

          if ($::operatingsystem == 'Debian' and versioncmp($::operatingsystemrelease, '6') <= 0) {
            fail("${::operatingsystem} ${::operatingsystemrelease} not supported")
          }

          if ($::operatingsystem == 'Debian' and versioncmp($::operatingsystemrelease, '8') >= 0) or ($::operatingsystem == 'Ubuntu' and versioncmp($::operatingsystemrelease, '13.10') >= 0)  {
            $apache_version = '2.4'
          } else {
            $apache_version = '2.2'
          }
        }
        default: {
          fail("${::operatingsystem} not supported")
        }
      }

     }

    'RedHat': {

      case $::operatingsystem {
        'CentOS', 'Fedora': {
          $datadirectory = '/var/www/html/owncloud/data'
          $documentroot  = '/var/www/html/owncloud'
          $www_user      = 'apache'
          $www_group     = 'apache'

          if ($::operatingsystem == 'Fedora') {
            $package_name  = 'owncloud-server'
          } else {
            $package_name  = 'owncloud'
          }

          if ($::operatingsystem == 'Fedora' and versioncmp($::operatingsystemrelease, '18') >= 0) or ($::operatingsystem != 'Fedora' and versioncmp($::operatingsystemrelease, '7') >= 0) {
            $apache_version = '2.4'
          } else {
            $apache_version = '2.2'
          }
        }
        default: {
          fail("${::operatingsystem} not supported")
        }
      }

     }

    default: {
      fail("${::operatingsystem} not supported")
    }

  }

}
