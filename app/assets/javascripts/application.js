//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min

$(document).ready(function(){
  $("form#new_provider").on('submit', function(e){
    e.preventDefault();
    submitProvider()
  })

  $('#newIspModal').on('shown.bs.modal', function () {
    $('span.response_message').text('')
  });

  function submitProvider(){
    $.post("/api/providers", $('#new_provider').serialize(), function(data) {
      if (data['status'] == 'failure'){
        $('span.response_message').removeClass('success')
        $('span.response_message').not(".failure").addClass('failure')
        $('span.response_message').text(data['message'])
      }
      else{
        $('span.response_message').text('');
        $('span.response_message').removeClass('failure')
        $('span.response_message').not(".success").addClass('success')
        $('span.response_message').text(data['message'])
        $("#provider_name, #provider_lowest_price, #provider_rating, #provider_max_speed, #provider_description, #provider_contact_no, #provider_email, #provider_url, #provider_image").val("");
        $("#newIspModal").modal('hide')
        provider = data['provider']
        var row = ""
        row += "<tr>"
        row += "<td>" + provider['name'] + "</td>"
        row += "<td>" + provider['lowest_price'] + "</td>"
        row += "<td>" + provider['rating'] + "</td>"
        row += "<td>" + provider['max_speed'] + "</td>"
        row += "<td>" + provider['description'] + "</td>"
        row += "<td>" + provider['contact_no'] + "</td>"
        row += "<td>" + provider['email'] + "</td>"

        row += "<td><a target='_blank' class= btn btn-sm btn-primary href=" + provider['url'] + ">" + provider['url'] + "</a></td>"
        row += "<td><a class= btn btn-sm btn-primary href= /provider/" + provider['id'] + ">Show</a></td>"
        $('tbody#providers_list').append(row)
      }
    });
  }
});


