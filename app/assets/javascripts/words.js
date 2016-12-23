$(document).on('turbolinks:load', function() {
  const cate_id = $('#category_id');
  const search = $('#search');
  const table = $('#word_table tbody');

  function send_request(input_search, category){
    alert(input_search+''+ category);
    $.ajax({
      url: '/admin/words',
      type: 'GET',
      data: {search: input_search, category_id: category},
      success: function(response){
        table.empty();
         $('#list').html(response);
         console.log(response);
      }
    });
  }

  cate_id.change(function(){
    var category = this.value;
    search.change(function(){
      var input_search = $(this).val();
      send_request(input_search,category);
    });
  });
});
