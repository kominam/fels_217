$(document).on 'click', '.add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('answers').replace(regexp, time))
  event.preventDefault()

$(document).on 'click', '.remove_fields', (event) ->
  event.preventDefault()
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('.answer').hide();
