#title           :Init.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class definition to install and configure Owncloud.
#author		 :Baptistejtlt
#date            :20160606   
#==============================================================================

class owncloud (
  $admin_pass      = 'administrator',
  $admin_user      = 'Passw0rd',
  $db_host         = 'localhost',
  $db_name         = 'owncloud',
  $db_table_prefix = '',
  $db_pass         = 'Passw0rd',
  $db_user         = 'administrator',
  $db_type         = 'mysql',
  $http_port       = 80,
  $https_port      = 443,
  $manage_apache   = true,
  $manage_db       = true,
  $manage_phpmysql = true,
  $manage_repo     = true,
  $manage_skeleton = true,
  $manage_vhost    = true,
  $ssl             = false,
  $ssl_ca          = undef,
  $ssl_cert        = undef,
  $ssl_chain       = undef,
  $ssl_key         = undef,
  $trusted_domains = '',
  $url             = "owncloud.${::domain}",
  $datadirectory   = $::owncloud::params::datadirectory,
)

inherits ::owncloud::params {
}

  class { '::owncloud::install': } ->
  class { '::owncloud::apache': } ->
  class { '::owncloud::config': } ->
  Class['::owncloud']
}
