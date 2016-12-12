$(document).on('turbolinks:load', function() {
  $('.update').click(function(event){
    event.preventDefault();
    var id = $(this).attr('id');
    $('#edit_' + id).modal();
    $('#update_' + id).click(function(){
      update_category(id);
      $('#edit_' + id).modal('hide');
    });
  });

  function update_category(id){
    form = $('#edit_category_'+id);
    $.ajax({
      url: '/admin/categories/' + id,
      type: 'PUT',
      data: form.serialize(),
      success: function(data) {
        $('#cate_name_'+id).text(data.name);
      }
    });
  }

  $('.del').click(function(event){
    event.preventDefault();
    var del_id = $(this).attr('id');
    $.ajax({
      url: '/admin/categories/' + del_id,
      method: 'DELETE',
      success: function(){
        $('#cate_'+del_id).remove();
        location.reload();
      }
    });
  });;

  $('#createCate').click(function(event){
    event.preventDefault();
    $('#newCate').modal();
  });

  $('#create-category').click(function(){
    create_category();
    location.reload();
    $('#newCate').modal('hide');
  });

  function create_category(){
    create_form = $('#newCate');
    $.ajax({
      url: '/admin/categories',
      type: 'POST',
      data: create_form.serialize(),
      dataType:'json',
      success: function() {
        swal({
          title: 'Success !',
          text: 'Create successfully',
          type: 'success',
          timer: 2000
        });
      }
    });
  }
});
