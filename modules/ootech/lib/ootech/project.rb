module Ootech
	class Project
		def initialize(projectjson)
			require 'json'

			jsonfile = File.expand_path("../../../json/projects/#{projectjson}.json", __FILE__)
			
			@data = JSON.parse(File.read(jsonfile))
		end

		def get_value(param)
			if param.is_a?(Array)
				param = param[0]
			end

			val = @data[param]

			val
		end

		def single_val(param)
		  param = param[0]
		  val = get_value param
		  val
		end

		def env_names(param)
			envnames = @data["env"].keys
      puts envnames
      envnames
    end

    def is_enabled(param)
      param = param[0]
      enabled = true
      if !@data["enabled"].nil? and @data["enabled"] == false
        enabled = false
      end
      if !@data["env"][param]["enabled"].nil? and @data["env"][param]["enabled"] == false
        enabled = false
      end
      enabled
    end

    def envprops(param)
      param = param[0]
      props = {
        :ptype =>  @data["type"],
        :envname => param
      }
      @data["env"][param].each do |k,v|
        props[k] = v
      end

      puts props
      props
    end
	end
end