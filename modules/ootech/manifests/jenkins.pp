class ootech::jenkins {
	$projects = $ootech::params::projects.each { |$proj| 
		$type = ooprojectval($proj, "single_val", "type")
		$githubjson = ooprojectval($proj, "single_val", "githubuser")
		if $githubjson == '' {
			$githubuser = $ootech::params::githuborg
		}
		else {
			$githubuser = $githubjson
		}
		$githubrepo = ooprojectval($proj, "single_val", "githubrepo")
		github { "${githubuser}/${$githubrepo}":
			ensure => present,
			token  => 'bcc5fddfa319767cbff86e75555ee0084c5497d5',
			private => true,
		}
		ooprojectval($proj, "env_names").each { |$env|
			$nameprefix = $env.upcase
			case $type {
				'wordpress': {
					ootech::jenkins::wordpress { "${nameprefix}_${proj}":
						envname   => $env,
						jsonfile  => $proj,
						enabled   => ooprojectval($proj, "is_enabled", $env),
						envprops  => ooprojectval($proj, "envprops", $env),
						githuburl => "http://github.com/${githubuser}/${githubrepo}",
						gitrepo   => "git@github.com:${githubuser}/${githubrepo}.git",
						require	  => Github["${githubuser}/${$githubrepo}"],
					}
				}
			}
		}
	}

	file { "${jenkinshome}/jobs":
      ensure  => directory,
      owner   => $jenkinsuser,
      group   => $jenkinsgroup,
      mode    => 0755,
	}

	exec { 'jenkins_refresh':
		command => "curl -i -d '' http://127.0.0.1:8080/reload",
		path => [ "/usr/bin", "/bin" ],
		refreshonly => true,
	}

	Class["jenkins::package"] -> File["/var/lib/jenkins/jobs"] -> Ootech::Jenkins::Wordpress <| |> ~> Service['jenkins'] 
}