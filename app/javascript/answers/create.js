$(document).on('turbolinks:load', function(){
  $('form.new-answer').on('ajax:success', function(e) {
    const answer = e.detail[0];
    $('.answers').append(`<p>${answer.body}</p>`);
  })
  .on('ajax:error', function(e){
    const errors = e.detail[0];

    $.each(errors, function(index, value){
      $('.answer-errors').html(`<p>${index}. ${value}</p>`);
    })
  })
});