$(document).on('turbolinks:load', function() {
  const cate_id = $('#category_id');
  const search = $('#search');
  const state = $('#status');
  const table = $('#words_table tbody');

  function send_request(input_search, category){
    $.get('/words', $('form').serialize(),
      function(data, status) {
        table.html(data);
      }, 'html');
  }

  cate_id.on('change', function(){
    var category = this.value;
    search.on('change',function(){
      var input_search = $(this).val();
      send_request(input_search,category);
    });
  });

  search.on('change',function(){
    var input_search = $(this).val();
    cate_id.on('change', function(){
      var category = this.value;
      send_request(input_search,category);
    });
  });
});
