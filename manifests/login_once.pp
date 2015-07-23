# Manifest for easily adding login_once scripts.
define outset::login_once(
    $script,
    $priority = '10',
    $ensure = 'present',
    $update = false,
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }
    
    if $title !~ /^.*\.(|PY|py|sh|SH|rb|RB)$/ {
        fail('Invalid value for title. Must end in .py, .sh or .rb')
    }
    
    validate_bool ($update)
    
    if ($ensure == 'present') and ($update == true){
        file {"/usr/local/outset/login-once/${priority}-${title}":
            source => $script,
            owner  => 0,
            group  => 0,
            mode   => '0755',
            notify => Exec["outset_remove_once_${title}"],
        }
    }
    
    if ($ensure == 'present') and ($update == false){
        file {"/usr/local/outset/login-once/${priority}-${title}":
            source => $script,
            owner  => 0,
            group  => 0,
            mode   => '0755',
        }
    }

    exec { "outset_remove_once_${title}":
      command     => "/usr/local/outset/remove_once.sh ${priority}-${title}",
      refreshonly => true,
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/login-once/${priority}-${title}":
            ensure => absent,
        }
    }
}