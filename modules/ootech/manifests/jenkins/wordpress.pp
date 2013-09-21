define ootech::jenkins::wordpress(
	$jenkinshome = $ootech::params::jenkinshome,
	$rakefile	   = $ootech::params::rakefile,
	$raketasks	 = 'wordpress',
  $envname     = undef,
  $jsonfile    = undef,
  $jenkinsuser = $ootech::params::jenkinsuser,
  $jenkinsgroup = $ootech::params::jenkinsgroup,
  $enabled      = true,
  $envprops     = [],
  $gitrepo      = undef,
  $githuburl    = undef,
  $gitbranch    = undef,
  
) {
  if $enabled == true {
    
    file { "${jenkinshome}/jobs/${name}":
      ensure  => directory,
      owner   => $jenkinsuser,
      group   => $jenkinsgroup,
      mode    => 0755,
      require => File["${jenkinshome}/jobs"],
    }

    file { "${jenkinshome}/jobs/${name}/config.xml":
      ensure  => file,
      owner   => $jenkinsuser,
      group   => $jenkinsgroup,
      mode    => 0644,
      require => File["${jenkinshome}/jobs/${name}"],
      content => template('ootech/jenkins/wordpress.erb'),
    }
  }
  else {
    file { "${jenkinshome}/jobs/${name}":
      ensure => absent,
      force  => true,
    }
  }
	
}