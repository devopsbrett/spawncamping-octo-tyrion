require "net/https"
require "uri"
require "octokit"

Puppet::Type.type(:github).provide(:git) do 

	def exists?
		#puts "https://api.github.com/repos/#{resource[:name]}"#resource[:name]
		uri = URI.parse("https://api.github.com/repos/#{resource[:name]}?access_token=#{resource[:token]}")
		http = Net::HTTP.new(uri.host, uri.port)
    	http.use_ssl = true

    	request = Net::HTTP::Get.new(uri.request_uri)

	    response = http.request(request)

	    retval = true

    	unless response.code == "200"
			retval = false
		end
		retval
	end

	def create
		#uri = URI.parse("https://api.github.com/orgs/OgilvyOne/repos?access_token=#{resource[:token]}")
		orgname, reponame = resource[:name].split("/")

		client = Octokit::Client.new :access_token => resource[:token]
		repo = client.create_repo reponame, { 
			:private 	    => resource[:private], 
			:organization => 'OgilvyOne', 
			:has_wiki     => true, 
			:auto_init    => true, 
			:team_id      => 269192 
		}

		client.create_hook repo.full_name, 'sqsqueue', {:aws_secret_key=>"BGyrr/Gz+Le9eh6dW2DQ6BbxMSeScKQPtBiNnB/p", :aws_access_key=>"AKIAI55D2XKIQDVYXZTA", :sqs_queue_name=>"otech-jenkins"}

		
	end
end