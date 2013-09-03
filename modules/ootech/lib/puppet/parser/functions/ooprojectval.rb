require File.expand_path('../../../../ootech/project', __FILE__)

module Puppet::Parser::Functions
	@special
  newfunction(:ooprojectval, :type => :rvalue) do |*args|
    if args[0].is_a?(Array)
      args = args[0]
    end

    @projectdata = Ootech::Project.new(args.shift)

    callfunc = args.shift

    projectval = @projectdata.send("#{callfunc}".to_sym, args)

    projectval
  end

end
