#!/usr/bin/env ruby
require "net/https"
require "uri"
require "octokit"

def clone_json_configs(token, repo)
	


def pull_latest_configs
	#make sure the repo has already been cloned
	clone_json_configs ENV['GITTOKEN'], ENV['JSONREPO'] unless File.exists?('/var/local/jsonconfig')
end

pull_latest_configs
#puts "JSON REPO"