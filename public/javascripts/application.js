$(document).ready(function () {

  $("form.new_developer, form.edit_developer").validate({
    debug: true,
    rules: {
      "developer[name]": {
        required: true, 
        maxlength: 50
      }
    }, 
    messages: {
      "developer[name]": {
        required: "<br>A name is required.", 
        maxlength: "<br>The name can not be longer than 50 characters"
      }
    },
    submitHandler: function(form) {
      form.submit();
    }

  });

  $("form.new_bug, form.edit_bug").validate({
    debug: true,
    rules: {
      "bug[title]": {
        required: true, 
        maxlength: 50
      },
      "bug[description]": {
        required: true, 
        maxlength: 200
      },
      "bug[status]": {
        required: true
      }
      ,
      "bug[developer_id]": {
        required: true
      }
    }, 
    messages: {
      "bug[title]": {
        required: "<br>A title is required.", 
        maxlength: "<br>The title can not be longer than 50 characters"
      },
      "bug[description]": {
        required: "<br>A description is required.", 
        maxlength: "<br>The description can not be longer than 50 characters"
      },
      "bug[status]": {
        required: "<br>A status must be selected."
      }
      ,
      "bug[developer_id]": {
        required: "<br>A developer must be selected."
      }
    },
    submitHandler: function(form) {
      form.submit();
    }
  });
});
