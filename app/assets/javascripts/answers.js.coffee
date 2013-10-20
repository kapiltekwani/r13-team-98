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
      width: "380px;"
      formatResult: format
      formatSelection: format
      escapeMarkup: (m) ->
        m
  
    $(".answer-form").submit ->
      unless $("#answer_friend_ids").val()?
        alert "Please select a friend before you submit the form"
        false

  if typeof pie_chart_label != 'undefined' 
    r = Raphael("pie_chart")
    pie = r.piechart(360, 170, 150, pie_chart,
            legend: pie_chart_label
    )
    pie.hover (->
      @sector.stop()
      @sector.scale 1.1, 1.1, @cx, @cy
      if @label
        @label[0].stop()
        @label[0].attr r: 7.5
        @label[1].attr "font-weight": 800
    ), ->
      @sector.animate
        transform: "s1 1 " + @cx + " " + @cy
      , 500, "bounce"
      if @label
        @label[0].animate
          r: 5
        , 500, "bounce"
        @label[1].attr "font-weight": 400
  
