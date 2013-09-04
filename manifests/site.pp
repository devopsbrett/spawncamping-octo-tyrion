filebucket { 'main':
  server => 'puppet.ec2.internal',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

node 'default' {
	#stuff
}

node 'httpd' inherits 'default' {
	#install web server
	include apache
}

node /^web.dev*$/ inherits 'httpd' {
	#do stuff
} 

node /^jenkins.*$/ inherits 'default' {
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
		'subversion',
		'token-macro',
	]
	jenkins::plugin {$plugins:}

} 