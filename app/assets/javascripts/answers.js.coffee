$(document).ready ->
  format = (item) ->
    item.text
  
  $(document).ready ->
    format = (state) ->
      return state.text  unless state.id # optgroup
      "<img class='flag' src='https://graph.facebook.com/" + state.id + "/picture'/>" + state.text
    $("#answer_friend_ids").popover
      "data-trigger": "click"
      "data-html": true
      "data-placement": "right"
      "data-content": "hello how are you"
  
    $("#answer_friend_ids").select2
      width: "400px;"
      formatResult: format
      formatSelection: format
      escapeMarkup: (m) ->
        m
  
    $(".answer-form").submit ->
      unless $("#answer_friend_ids").val()?
        alert "Please select a friend before you submit the form"
        false
  
  
