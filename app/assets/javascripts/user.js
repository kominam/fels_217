$(document).on('turbolinks:load', function() {
  const search = $('#q');
  const table = $('#list_user tbody');

  function send_request(input_search){
    $.get('/users', $('form').serialize(),
      function(data, status) {
        table.html(data);
      }, 'html');
  }

  search.keyup(function(){
    var input_search = $(this).val().toLowerCase();
      send_request(input_search);
  });
});
