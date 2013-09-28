class ootech::setup {
    file { '/var/local/scripts':
		source  => "puppet:///modules/ootech/scripts",
		recurse => true,
		ensure  => directory,
        backup  => false,
    }

    exec { '/var/local/scripts/.create_symlinks.sh':
        require => File['/var/local/scripts'],
    }
}