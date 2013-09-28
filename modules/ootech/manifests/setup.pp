class ootech::setup {
    file { '/var/local/scripts':
		source  => "puppet:///modules/ootech/scripts",
		recurse => true,
		ensure  => directory,
        backup  => false,
    }

    exec { '/var/local/scripts/.create_symlinks.sh':
        subscribe   => File["/var/local/scripts"],
        refreshonly => true,
    }
}