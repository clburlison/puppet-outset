# Manifest for easily adding login-once scripts.
define outset::login_once(
    $script,
    $priority = '10',
    $ensure = 'present',
    $type = 'file',
    $update = false
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }

    validate_bool ($update)
    
    if $ensure == 'present'{
        if $type == 'file'{
            file {"/usr/local/outset/login-once/${priority}-${title}":
                source => $script,
                owner  => root,
                group  => wheel,
                mode   => '0755',
            }
        }

        if $type == 'template'{
            file {"/usr/local/outset/login-once/${priority}-${title}":
                content => $script,
                owner   => root,
                group   => wheel,
                mode    => '0755',
            }
        }
        
        if $update == true{
          exec { "outset_remove_once_${title}":
            command     => "/usr/local/outset/remove_once.sh ${priority}-${title}",
            refreshonly => true,
            subscribe   => File["/usr/local/outset/login-once/${priority}-${title}"],
          }
        }
        
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/login-once/${priority}-${title}":
            ensure => absent,
        }
    }
}