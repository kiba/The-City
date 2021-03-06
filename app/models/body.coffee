class Body
  constructor: (type) ->
    switch(type)
      when 1
        @parts = human_body()
      when 2
        @parts = boar_body()
    @death = 0
    @hand = 0 #0 for operational hands. #1 means he only have one hand. #2 means that he lost all his hand functionality
    @leg = 0
  check_death: () ->
    if @death == 1
      return true
    else
      return false
  update_ability: (n) ->

    switch(n)
      when 0
        if (@parts[1].disabled == true) && (@parts[4].disabled == true)
          @hand = 2
          return "hand_destroy"
        else if (@parts[1].disabled == true) || (@parts[4].disabled == true)
          @hand = 1
          return "hand"
      when 1
        if (@parts[2].disabled == true) && (@parts[3].disabled == true)
          @leg = 2
          return "leg_destroy"
        else if (@parts[2].disabled == true) || (@parts[3].disabled == true)
          @leg = 1
          return "leg"
