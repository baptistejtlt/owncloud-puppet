#title           :Apache.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class definition to configure Apache.
#author		 :Baptistejtlt
#date            :20160608   
#==============================================================================

class owncloud::apache {

  if $::owncloud::manage_apache {
    class { '::apache':
      default_vhost => false,
      mpm_module    => 'prefork',
      purge_configs => false,
    }

    include '::apache::mod::php', '::apache::mod::rewrite', '::apache::mod::ssl'

    if $::osfamily == 'Debian' {
      file { '/etc/apache2/sites-enabled/000-default.conf':
        ensure  => absent,
        require => Class['::apache'],
        notify  => Class['::apache::service'],
      }
    }
  }

  if $::owncloud::manage_vhost {
    $vhost_directories_common = {
        path            => $::owncloud::documentroot,
        options         => ['Indexes', 'FollowSymLinks', 'MultiViews'],
        allow_override  => 'All',
        custom_fragment => 'Dav Off',
      }

    if $::owncloud::apache_version == '2.2' {
      $vhost_directories_version = {
        order   => 'allow,deny',
        allow   => 'from All',
        satisfy => 'Any',
      }
    } else {
      $vhost_directories_version = {
        require => 'all granted'
      }
    }

    $vhost_directories = merge($vhost_directories_common, $vhost_directories_version)

apache::vhost { 'owncloud-http':
        servername  => $::owncloud::url,
        port        => $::owncloud::http_port,
        docroot     => $::owncloud::documentroot,
        directories => $vhost_directories,
      }

}
