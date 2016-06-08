#title           :Config.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class definition to set servie config.
#author		 :Baptistejtlt
#date            :20160608   
#==============================================================================


class owncloud::config {

  exec { "mkdir -p ${::owncloud::datadirectory}":
    path   => ['/bin', '/usr/bin'],
    unless => "test -d ${::owncloud::datadirectory}"
  }

  file { $::owncloud::datadirectory:
    ensure  => directory,
    owner   => $::owncloud::www_user,
    group   => $::owncloud::www_user,
    mode    => '0770',
    require => Exec["mkdir -p ${::owncloud::datadirectory}"],
  }

    if $::owncloud::db_type == 'mysql' {
      if $::owncloud::db_host == 'localhost' {
        mysql::db { $::owncloud::db_name:
          user     => $::owncloud::db_user,
          password => $::owncloud::db_pass,
          host     => $::owncloud::db_host,
          grant    => ['all'],
        }
      } else {
        @@mysql::db { $::owncloud::db_name:
          user     => $::owncloud::db_user,
          password => $::owncloud::db_pass,
          host     => $::ipaddress,
          grant    => ['all'],
          tag      => 'owncloud',
        }
      }
  }
