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

    if $ensure == 'present'{
        if $type == 'file'{
            file {"/usr/local/outset/boot-every/${priority}-${title}":
                source => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }

        if $type == 'template'{
            file {"/usr/local/outset/boot-every/${priority}-${title}":
                content => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }

        if $immediate_run == true {
            exec { "/usr/local/outset/boot-every/${priority}-${title}":
                path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
                refreshonly => true,
                subscribe => File["/usr/local/outset/boot-every/${priority}-${title}"],
            }
        }
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/boot-every/${priority}-${title}":
            ensure => absent,
        }
    }
}