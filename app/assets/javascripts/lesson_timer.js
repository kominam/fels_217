$(document).on('turbolinks:load', function() {
  function CountDown(duration, display) {
    if (!isNaN(duration)) {
      var timer = duration, minutes, seconds;
      var interVal =  setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? '0' + minutes : minutes;
        seconds = seconds < 10 ? '0' + seconds : seconds;

        $(display).html('<b>' + minutes + 'm : ' + seconds + 's' + '</b>');
        if (--timer < 0) {
          timer = duration;
          SubmitFunction();
          $('#display').empty();
          clearInterval(interVal)
        }
      },1000);
    }
  }

  function SubmitFunction(){
    $('form').submit();
  }

  CountDown(300,$('#display'));
});
