Puppet::Type.newtype(:github) do
	ensurable

	newparam(:name, :namevar => true) do 
		desc "The name of the repo on github. Should be in the form 
		{user/org}/{reponame} eg. OgilvyOne/ba-BrandHub"
	end

	newparam(:token) do 
		desc "The OAuth token to use when connecting to the github API"
	end

	newparam(:private) do 
		desc "Should this be a private repository"
	end

	validate do 
		fail('token should be present and a valid Github OAuth token') if self[:token].nil?
	end
end