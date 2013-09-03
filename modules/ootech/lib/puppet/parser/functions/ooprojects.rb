module Puppet::Parser::Functions
  newfunction(:ooprojects, :type => :rvalue) do |*args|
    if args[0].is_a?(Array)
      args = args[0]
    end

    projectsdir = File.expand_path("../../../../../json/projects", __FILE__)

    projectnames = Dir.glob(File.join(projectsdir, "*.json"))
    projectnames.map! {|x| File.basename(x, ".json") }

    projectnames
  end
end
