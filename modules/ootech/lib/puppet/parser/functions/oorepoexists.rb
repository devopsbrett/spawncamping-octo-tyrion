require "net/https"
require "uri"

module Puppet::Parser::Functions
  newfunction(:oorepoexists, :type => :rvalue) do |*args|
    if args[0].is_a?(Array)
      args = args[0]
    end

    puts "Before URI parse"

    uri = URI.parse("https://api.github.com/repos/#{args[0]}/#{args[1]}?access_token=#{args[2]}")

    puts "Before HTTP object creation"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)

    puts response.code
    response.code == "200"
  end
end
