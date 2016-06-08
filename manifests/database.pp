#title           :Database.pp
#description     :This file is a part of module puppet-owncloud.
#usage           :Class called by from owncloud.
#author		 :Baptistejtlt
#date            :20160608   
#==============================================================================

class owncloud::database {

  Mysql::Db <<| tag == 'owncloud' |>>

}
