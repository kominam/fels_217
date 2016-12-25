$(document).on('turbolinks:load', function() {
  const search = $('#search');
  const table = $('#list_category tbody');

  function send_request(input_search){
    $.get('/categories', $('form').serialize(),
      function(data, status) {
        table.html(data);
      }, 'html');
  }

  search.keyup(function(){
    let input_search = $(this).val().toLowerCase();
      send_request(input_search);
  });
});
