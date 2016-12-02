$(document).on('turbolinks:load', function() {
  $('button').click(function(event){
    event.preventDefault();
    var id = $(this).attr('id');
    $('#edit_'+id).modal();
  });
});
