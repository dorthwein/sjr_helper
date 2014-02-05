module SjrHelper
	module Helpers
		def sjr_edit_if_field_tag condition, object, field, options={}, field_options={}, form_options={}
			options[:activator] ||= false
			options[:input_type] ||= :text_field
			form_options[:style] ||= ''
			form_options[:style] = form_options[:style] + '; display:none;'

			data = {
				data: {
					'sjr-field' => field, 
					'sjr-id' => object.id.to_s,
					'sjr-class' => object.class.to_s,
					'sjr-activator' => options[:activator],
				}
			}

			field_options = field_options.merge(data)


			content_tag(:span, 'data-sjr-editable' => true) do 
				form = nil
				if(condition == true)
					form = sjr_form_tag(object, field, options, field_options, form_options)
				end

				sjr_tag(object, field, field_options) + form
			end			
		end
		def sjr_edit_if_activator_tag condition, object, field, options={}
			options[:label] ||= 'edit'
			options[:html_tag] ||= :a
			data = { data: {
				'sjr-activator-tag' => true,
				'sjr-field' => field, 
				'sjr-id' => object.id.to_s,
				'sjr-class' => object.class.to_s,				
			} }
			options = options.merge(data)
			if condition
				content_tag(options[:html_tag], options[:label], options)
			else
				nil
			end
		end

		def sjr_form_tag object, field, options={}, field_options={}, form_options={}
			options[:input_type] ||= :text_field
			form_defaults = {remote: true}

			field_options = field_options.merge({data: {'sjr-input' => true}})

			form_options = form_options.merge(form_defaults)
			form_for(object, html: form_options) do |f|
				f.send(options[:input_type], field, field_options)
			end
		end

		def sjr_tag object, field, options={}
			options[:data] ||= {}
			options[:data] = options[:data].merge({'sjr-field' => field, 'sjr-id' => object.id.to_s, 'sjr-class' => object.class.to_s, 'sjr-display-tag' => true })						
			content_tag(:span, object.send(field), options)
		end		

		def sjr_collection_tag collection, html_tag=:ul, options={}, &code
			defaults = {data: {'sjr-collection' => true, 'sjr-class' => collection.first.class.to_s }}
			options = defaults.merge(options)			
			content_tag(html_tag, options) do 
			    collection.each do |n|
			      yield(n)
			    end
			end
		end
	end
end

