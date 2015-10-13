puppet-outset
===================

Setup outset using puppet. 

Original project found here: [chilcote/outset](https://github.com/chilcote/outset).

## Usage

Using a file distributed via pluginsync

``` puppet
outset::everyboot{'disable_wifi.sh':
    script => 'puppet:///modules/mac_base/disable_wifi/disable_wifi.sh'
}
```

Using a template, and a high priority value to make it run last (default is 10)

``` puppet
outset::login_once{'dock.sh':
    script  => template('mac_base/dock/dock.sh.erb'),
    type    => 'template',
    priorty => 99
}

```
Compound example: pluginsync, hiera, and update parameter. 
* Using a file distributed via pluginsync
* Using a hiera lookup and set a default incase the lookup doesn't resolve
* Update parameter enabled. When 'update' is set to ``true`` puppet will automatically remove the login-once item from ``~/Library/Preferences/com.github.outset.once.plist`` when a change to the script has been made. Puppet is already storing a hash for each file being managed via pluginsync. Therefore a modification to the script will change the hash, which in turn will have puppet run a script removing the item. The end result is - run once until I say to run again.


``` puppet
outset::login_once{'district_dock.sh':
    script   => hiera('outsetdock::script', 'puppet:///modules/profile/dockutil/district_dock.sh'),
    update   => true,
    priority => '5'
}

```