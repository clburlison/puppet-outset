# Manifest for easily adding login-every scripts.
define outset::login_every(
    $script,
    $priority = '10',
    $ensure = 'present',
    $type = 'file'
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }

    if $ensure == 'present'{
        if $type == 'file'{
            file {"/usr/local/outset/login-every/${priority}-${title}":
                source => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }
        
        if $type == 'template'{
            file {"/usr/local/outset/login-every/${priority}-${title}":
                content => $script,
                owner   => root,
                group   => wheel,
                mode    => '0755',
            }
        }
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/login-every/${priority}-${title}":
            ensure => absent,
        }
    }
}