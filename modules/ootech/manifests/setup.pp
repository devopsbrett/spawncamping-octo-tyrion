class ootech::setup {
    file { '/var/local/scripts':
		source  => "puppet:///modules/ootech/scripts",
		recurse => true,
		ensure  => directory,
    }
}