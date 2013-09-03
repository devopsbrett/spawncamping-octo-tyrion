filebucket { 'main':
  server => 'ip-10-190-41-55.ec2.internal',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

node 'default' {
	#stuff
}

node /^jenkins.*$/ inherits 'default' {
	include jenkins
	jenkins::plugin {'swarm':}

} 