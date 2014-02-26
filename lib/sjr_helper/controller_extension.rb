module SjrHelper
	module ControllerExtension
	    def respond_with_sjr(obj, opts={})
	      obj.changed? ? respond_sjr_error(obj, opts) : respond_sjr_ok(obj, opts)
	    end		
	private
		def respond_sjr_ok(obj, opts={})
        	view_path = 'sjr_helper/sjr_defaults/' + action_name
        	render view_path, locals: {object: obj, opts: opts}
		end

		def respond_sjr_error(obj, opts={})
         	view_path = 'sjr_helper/sjr_defaults/' + 'error'
         	render view_path
		end
	end	
end
