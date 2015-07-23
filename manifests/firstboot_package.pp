# Manifest for easily adding firstboot packages.
define outset::firstboot_package(
    $pkg,
    $priority = '10',
    $ensure = 'present'
){
    require outset::setup

    if $ensure != 'present' and $ensure !='absent'{
        fail('Invalid value for ensure')
    }
    
    if $title !~ /^.*\.(|pkg|PKG)$/ {
        fail('Invalid value for title. Must end in .pkg')
    }

    if $ensure == 'present'{
        file {"/usr/local/outset/firstboot-packages/${priority}-${title}":
            source => $pkg,
            owner  => 0,
            group  => 0,
            mode   => '0755',
        }
    }

    if $ensure == 'absent' {
        file {"/usr/local/outset/firstboot-packages/${priority}-${title}":
            ensure => absent,
        }
    }
}