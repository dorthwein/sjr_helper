// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_self
//= require_tree ./sjr_helper


var SjrEditor = function(e) {
	var editor = this
	editor.element = e;
	editor.display_field = editor.element.children('span');	
	editor.object_id = editor.display_field.data('sjrId');
	editor.class_name = editor.display_field.data('sjrClass');
	editor.field = editor.display_field.data('sjrField');
	editor.form = editor.element.children('form');
	editor.input_el = editor.form.children('[data-sjr-input="true"]');

//	this.initOptions();
//	this.bindForm();
//	$().on('click', function(){alert('t')});
	
	
	if(editor.display_field.data('sjrActivator') != false){
		// If display field not false - then set to value.
		editor.activator = $(editor.display_field.data('sjrActivator'));
		alert('t')
	} else if( $('[data-sjr-activator-tag="true"][data-sjr-class="' + editor.class_name + '"][data-sjr-field="'+ editor.field +'"][data-sjr-id="' + editor.object_id + '"]').length ){		
		editor.activator = $('[data-sjr-activator-tag="true"][data-sjr-class="' + editor.class_name + '"][data-sjr-field="'+ editor.field +'"][data-sjr-id="' + editor.object_id + '"]');
	} else { 
		editor.activator = editor.display_field;		
	}	
	
	editor.activator.on('click', function(){			
		editor.activate();
	})
	
	editor.input_el.on('blur', function(){
		editor.deactivate();
	})

	editor.element.on('keydown', editor.input_el, function(ev) {
		if (ev.keyCode == 27){
			editor.deactivate();
		}
		if (ev.keyCode == 13 || ev.keyCode == 9){
			editor.send();
			editor.deactivate();			

		}			
	})	
}

SjrEditor.prototype = {
	activate : function(){
		this.activator.hide();
		this.display_field.hide();
		this.form.show();
		this.input_el.focus();
		
	},
	deactivate : function(){		
		this.activator.show();
		this.display_field.show();
		this.form.hide();		
	},
	abort : function(){
		
	},
	send : function(){
		this.form.submit()
	},
}

jQuery.fn.sjr_edit = function() {  
  function setSjrEdit(element) {
    if (!element.data('sjrEditor')) {
      element.data('sjrEditor', new SjrEditor(element));
      return true;
    }
  }
  this.each(function () {
	setSjrEdit($(this));
  });
  return this;
};



$(document).on('page:change', function(){ 
	$('[data-sjr-editable="true"]').sjr_edit()//each(function(index, element){ 
})