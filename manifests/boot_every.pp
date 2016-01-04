# Manifest for easily adding boot-every scripts and packages.
define outset::boot_every(
    $script,
    $priority = '10',
    $ensure = 'present'
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }

    # No longer valid for outset v1.0.3
    # if $title !~ /^.*\.(|PY|py|sh|SH|rb|RB)$/ {
    #     fail('Invalid value for title. Must end in .py, .sh or .rb')
    # }

    if $ensure == 'present'{
        file {"/usr/local/outset/boot-every/${priority}-${title}":
            source => $script,
            owner  => root,
            group  => wheel,
            mode   => '0755',
        }
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/boot-every/${priority}-${title}":
            ensure => absent,
        }
    }
}