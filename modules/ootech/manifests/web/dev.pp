class ootech::web::dev {
	$projects = $ootech::params::projects.each { |$proj| 
		ooprojectval($proj, "env_names").each { |$env|
			$nameprefix = $env.upcase
			if $nameprefix == 'DEV' {
				$envprops = ooprojectval($proj, "envprops", $env)
				apache::vhost { "${envprops['url']}":
					port   => '80',
					docroot  => "/var/www/${$nameprefix}_${proj}",
					require	  => File["/var/www/${$nameprefix}_${proj}"],
				}
				
				file { "/var/www/${$nameprefix}_${proj}":
					ensure => directory,
					owner	=> 'www-data',
					group 	=> 'www-data',
				}
			}
		}
	}

}