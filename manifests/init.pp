# == Class: wine
#
# Full description of class wine here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'wine':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class wine(
  $ensure           = 'present',
  $package_branch   = 'devel',
  $package_name     = 'winehq',
  $ppa_uri          = 'ppa:wine/wine-builds',
) {
  include apt


  case $::lsbdistid {
    'Ubuntu': {
      $final_package_name = "${package_name}-${package_branch}"
      exec { 'dpkg --add-architecture i386':
        path   => '/usr/bin',
        before => Package[$final_package_name],
      }
      apt::ppa { $ppa_uri:
        before => Package[$final_package_name],
      }
    }
  }

  package { $final_package_name:
    ensure => $ensure,
  }
}
