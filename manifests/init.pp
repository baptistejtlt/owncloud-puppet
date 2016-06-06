#title           :init.pp
#description     :This file is a part of module puppet-owncloud.
#author		 :baptistejtlt
#date            :20160606   
#==============================================================================

class owncloud (
  $admin_pass      = '',
  $admin_user      = '',
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

  validate_bool($manage_apache)
  validate_bool($manage_db)
  validate_bool($manage_repo)
  validate_bool($manage_skeleton)
  validate_bool($manage_vhost)
  validate_bool($ssl)

  validate_re($db_type, '^mysql$', '$database must be \'mysql\'')

  class { '::owncloud::install': } ->
  class { '::owncloud::apache': } ->
  class { '::owncloud::config': } ->
  Class['::owncloud']
}
