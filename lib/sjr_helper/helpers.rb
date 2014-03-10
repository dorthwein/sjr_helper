module SjrHelper
	module Helpers

	#########################
	# Conditional Tags Etc. #
	#########################
		def sjr_edit_if_field_tag condition, object, field, input_type=:text_field, input_args=:nil, display_as=false, activator=:false, options={}
			if(condition == true)
				content_tag(:span, 'data-sjr-editable' => true) do
					sjr_field_tag(object, field, display_as, activator, options) + sjr_form_tag(object, field, input_type, input_args, display_as, options)
				end
			else
				sjr_field_tag(object, field, display_as, activator, options)
			end
		end

		def sjr_edit_if_activator_tag condition, object, field, options={}
			label = options[:label] ||= 'edit'
			options.delete(:label)
			options[:html_tag] ||= :a
			data = { data: {
				'sjr-activator-tag' => true,
				'sjr-field' => field, 
				'sjr-id' => object.id.to_s,
				'sjr-class' => object.class.to_s,				
			} }
			options = options.merge(data)
			if condition
				content_tag(options[:html_tag], label, options)
			else
				nil
			end
		end

		def sjr_delete_if_object_tag condition, object, options={} #, form_options={}
			if condition
				return sjr_delete_tag(object, options)
			else
				return nil
			end			
		end

	######################
	# Utility Tags Etc.  #
	######################
		def sjr_form_tag object, field, input_type=:text_field, input_args=:nil, display_as=false, options={} #, field_options={}, form_options={}
			options[:form] ||= {}
			options[:form][:remote] = true
			form_for(object, options[:form]) do |f|
				inputs = render_input(f, object, field, input_type, input_args, options[:form])
				if display_as != false				
					inputs += hidden_field_tag(:display_field, field)
					inputs += hidden_field_tag(:display_as, display_as)
				end				
				inputs
			end
		end

		def sjr_delete_tag object, options={} #, form_options={}
			label = options[:label] ||= "<i class='fa fa-times'></i>".html_safe
			form_defaults = {remote: true, method: :delete}
			options[:form] ||= {}
			options[:form] = options[:form].merge(form_defaults)

			form_for(object, options[:form]) do |f|
 				link_to(label, 'javascript:void(0);', onclick: "$(this).closest('form').submit()")
			end
		end

	#####################
	# Display Tags Etc. #
	#####################
		def sjr_field_tag object, field, display_as=false, activator=:false, options={}
			display_as = display_as || field
			render partial: 'sjr_helper/display/show_field', locals: { object: object, display_as: display_as, activator: activator, field: field, options: options}
		end

		def sjr_object_tag object, html_tag=:div, options={}, &code
			options[:data] ||= {}
			options[:data] = options[:data].merge({'sjr-object' => true, 'sjr-id' => object.id.to_s, 'sjr-class' => object.class.to_s, 'sjr-display-tag' => true })						
			content_tag(html_tag, options) do 
				yield
			end
		end

		def sjr_collection_tag collection, html_tag=:ul, options={}, &code
			defaults = {data: {'sjr-collection' => true, 'sjr-class' => collection.klass.to_s }}
			options = defaults.merge(options)			
			content_tag(html_tag, options) do 
			    collection.each do |n|
			      yield(n)
			    end
			end
		end
		private
			def render_input form, object, field, input_type, input_args=nil, options={}
				options[:input] ||= {}
				render(partial: 'sjr_helper/inputs/' + input_type.to_s, locals: {f: form, object: object, field: field, input_args: input_args, options: options[:input]})
			end
	end
end

