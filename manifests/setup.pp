# Setup manifest for installing Outset.
class outset::setup{
    if $::osfamily != 'Darwin' {
        fail("Unsupported osfamily: ${::osfamily}")
      }

    if ! defined(File['/usr/local']) {
      file { '/usr/local':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset']) {
      file { '/usr/local/outset':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/everyboot-scripts']) {
      file { '/usr/local/outset/everyboot-scripts':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/firstboot-packages']) {
      file { '/usr/local/outset/firstboot-packages':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/firstboot-scripts']) {
      file { '/usr/local/outset/firstboot-scripts':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/login-every']) {
      file { '/usr/local/outset/login-every':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/login-once']) {
      file { '/usr/local/outset/login-once':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/FoundationPlist']) {
      file { '/usr/local/outset/FoundationPlist':
        ensure => directory,
      }
    }

    file {'/Library/LaunchAgents/com.github.outset.login.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.login.plist'
    }

    file {'/Library/LaunchDaemons/com.github.outset.boot.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.boot.plist'
    }

    file{'/usr/local/outset/outset':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/outset/outset'
    }

    file{'/usr/local/outset/FoundationPlist':
        owner   => root,
        group   => wheel,
        mode    => '0755',
        source  => 'puppet:///modules/outset/FoundationPlist',
        recurse => true
    }

    file{'/usr/local/outset/remove_once.sh':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/outset/remove_once.sh'
    }
}