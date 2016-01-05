# Setup manifest for installing Outset.
class outset::setup{
    if $::osfamily != 'Darwin' {
        fail("Unsupported osfamily: ${::osfamily}")
      }

    # Create outset directories
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

    if ! defined(File['/usr/local/outset/boot-every']) {
      file { '/usr/local/outset/boot-every':
        ensure => directory,
      }
    }

    if ! defined(File['/usr/local/outset/boot-once']) {
      file { '/usr/local/outset/boot-once':
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

    if ! defined(File['/usr/local/outset/on-demand']) {
      file { '/usr/local/outset/on-demand':
        ensure => directory,
      }
    }
    
    if ! defined(File['/usr/local/outset/share']) {
      file { '/usr/local/outset/share':
        ensure => directory,
      }
    }

    # This directory was removed with outset v1.0.3
    if ! defined(File['/usr/local/outset/everyboot-scripts']) {
      file { '/usr/local/outset/everyboot-scripts':
        ensure  => absent,
        recurse => true,
        force   => true,
      }
    }

    # This directory was removed with outset v1.0.3
    if ! defined(File['/usr/local/outset/firstboot-packages']) {
      file { '/usr/local/outset/firstboot-packages':
        ensure  => absent,
        recurse => true,
        force   => true,
      }
    }

    # This directory was removed with outset v1.0.3
    if ! defined(File['/usr/local/outset/firstboot-scripts']) {
      file { '/usr/local/outset/firstboot-scripts':
        ensure  => absent,
        recurse => true,
        force   => true,
      }
    }

    # Set Outset LaunchDaemons/Agent
    file {'/Library/LaunchDaemons/com.github.outset.boot.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.boot.plist'
    }

    file {'/Library/LaunchDaemons/com.github.outset.cleanup.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.cleanup.plist'
    }
    
    file {'/Library/LaunchAgents/com.github.outset.login.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.login.plist'
    }

    file {'/Library/LaunchAgents/com.github.outset.on-demand.plist':
        owner  => root,
        group  => wheel,
        mode   => '0644',
        source => 'puppet:///modules/outset/com.github.outset.on-demand.plist'
    }

    # Set Outset required files
    file{'/usr/local/outset/outset':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/outset/outset'
    }

    file{'/usr/local/outset/FoundationPlist':
        owner   => root,
        group   => wheel,
        mode    => '0644',
        source  => 'puppet:///modules/outset/FoundationPlist',
        recurse => true
    }

    file{'/usr/local/outset/remove_once.sh':
        owner  => root,
        group  => wheel,
        mode   => '0755',
        source => 'puppet:///modules/outset/remove_once.sh'
    }
    
    file{'/usr/local/outset/share/com.chilcote.outset.plist':
        owner   => root,
        group   => wheel,
        mode    => '0644',
        source  => 'puppet:///modules/outset/com.chilcote.outset.plist',
        require => File['/usr/local/outset/share']
    }
    
    # Start Outset launchd services
    service { 'com.github.outset.boot':
        enable   => true,
        ensure   => running,
        provider => 'launchd',
        require  => [ File['/Library/LaunchDaemons/com.github.outset.boot.plist'] ],
    }

    service { 'com.github.outset.cleanup':
        enable   => true,
        ensure   => running,
        provider => 'launchd',
        require  => [ File['/Library/LaunchDaemons/com.github.outset.cleanup.plist'] ],
    }

    service { 'com.github.outset.login':
        enable   => true,
        provider => 'launchd',
        require  => [ File['/Library/LaunchAgents/com.github.outset.login.plist'] ],
    }

    service { 'com.github.outset.on-demand':
        enable   => true,
        provider => 'launchd',
        require  => [ File['/Library/LaunchAgents/com.github.outset.on-demand.plist'] ],
    }
}