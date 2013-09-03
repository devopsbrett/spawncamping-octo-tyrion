class ootech::github(
	$githubuser  = undef,
	$githubrepo  = undef,
	$githubtoken = $ootech::params::githubtoken,
) {
	$testval = oorepoexists($githubuser, $githubrepo, $githubtoken)
	alert($testval)
	if $testval == false {
		alert("DO NOT CREATE REPO")
	}
	else {
		alert("CREATE REPO")
	}
}