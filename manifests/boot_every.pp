# Manifest for easily adding boot-every scripts and packages.
define outset::boot_every(
    $script,
    $priority = '10',
    $ensure = 'present',
    $type = 'file',
    $immediate_run = false,
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }

    if versioncmp($outset_version, '2.0.0') == -1 {
        if $title !~ /^.*\.(|PY|py|sh|SH|rb|RB)$/ {
            fail('Invalid value for title. Must end in .py, .sh or .rb')
        }
    }

    if versioncmp($outset_version, '2.0.0') >= 0 {
        # These were changed in 2.0.0
        $target = '/usr/local/outset/boot-every'
    } else {
        $target = '/usr/local/outset/everyboot-scripts'
    }

    if $ensure == 'present'{
        if $type == 'file'{
            file {"${target}/${priority}-${title}":
                source => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }

        if $type == 'template'{
            file {"${target}/${priority}-${title}":
                content => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }

        if $immediate_run == true {
            exec { "${target}/${priority}-${title}":
                path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
                refreshonly => true,
                subscribe => File["${target}/${priority}-${title}"],
            }
        }
    }

    if $ensure == 'absent' {
        file {"${target}/${priority}-${title}":
            ensure => absent,
        }
    }
}