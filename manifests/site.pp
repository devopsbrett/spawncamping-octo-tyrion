filebucket { 'main':
  server => 'puppet',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

node 'base' {
	class { 'ootech::setup': }
}

node 'httpd' inherits 'base' {
	#install web server
	include apache
}

node /^web.dev*$/ inherits 'httpd' {
	#do stuff
} 

node /^web.stage.*$/ inherits 'httpd' {
	#do stage
}

node /^web.qa.*$/ inherits 'httpd' {
	#do stage
}

node /^jenkins.*$/ inherits base {
	include jenkins
	$plugins = [
		'swarm',
		'ec2',
		'ant',
		'build-pipeline-plugin',
		'chucknorris',
		'conditional-buildstep',
		'credentials',
		'cvs',
		'debian-package-builder',
		'envinject',
		'flexible-publish',
		'git-client',
		'git',
		'github-api',
		'github',
		'github-sqs-plugin',
		'greenballs',
		'javadoc',
		'envfile',
		'jquery',
		'mailer',
		'rake',
		'translation',
		'ldap',
		'maven-plugin',
		'external-monitor-job',
		'pam-auth',
		'parameterized-trigger',
		'ruby-runtime',
		'run-condition',
		'rvm',
		's3',
		'ssh-credentials',
		'ssh-slaves',
		'ssh-agent',
		'subversion',
		'token-macro',
	]
	jenkins::plugin {$plugins:
		require => Class["jenkins::package"],
	}

	include ootech

	class { 'ootech::jenkins': }

} 
