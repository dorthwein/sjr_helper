# sjr-helper

# Summary

sjr-helper is a rails plugin that adds several helpers that make rails fields operation similar to a front-end framework within a full rails stack.  sjr-helper uses Sever-generated JavaScript Responses to update all appropiately tagged fields in the DOM.  It also adds inline editing helpers inspired by Bernat Farrero's BestInPlace gem (github.com/bernat/best_in_place).


# Installation
Add to bundler: `gem 'sjr-helper'`

# Useage
## In Controller
** Controler Response **
`respond_to do |format|
	format.js { respond_with_sjr( *object* ) }
end`

This response will first update all of the *sjr_tag* in the dom then render the normal .js reponse for that controller action.

## In Views
**To Display a field:** 
`<%= sjr_tag **object**, **field**, **options={}** %>`
This tag is not editable but will be updated if the model instance's field is updated using `format.js { respond_with_sjr( *object* ) }`

**To Display editable field:**
`<%= sjr_edit_if_field_tag condition, object, field, options={}, field_options={}, form_options={} %>`
This tag creates an inline editable field triggered by an on click activator if the condition param returns true.  The form field type can be set as options[:input_type] and must be a symbol matching a rails form view builder (example: f.input_field).  
The activator can be set with a normal html selector to *options[:activator]* or using the `<%= sjr_edit_if_activator_tag %>` tag.  If no activator is specified, the field will be editiable on click.

# Comments
This gem currently has no tests however pull requests should include tests.  Feel free to add and extend this gem any way you see fit!
