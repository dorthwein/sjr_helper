module SjrHelper
	module ControllerExtension
	    def respond_with_sjr(obj)
	      obj.changed? ? respond_sjr_error(obj) : respond_sjr_ok(obj)
	    end		
	private
		def respond_sjr_ok(obj)
        	view_path = 'sjr_defaults/' + action_name
        	render view_path, locals: {object: obj}
		end

		def respond_sjr_error(obj)
         	view_path = 'sjr_defaults/' + 'error'
         	render view_path
		end
	end	
end
