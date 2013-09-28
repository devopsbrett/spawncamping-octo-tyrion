class ootech::setup {
    file { '/var/local/scripts':
		source  => "puppet:///modules/ootech/scripts",
		recurse => true,
		ensure  => directory,
        backup  => false,
        notify  => Exec['/var/local/scripts/.create_symlinks.sh'],
    }

    exec { '/var/local/scripts/.create_symlinks.sh':
        refreshonly => true,
    }
}