class Stockpile
  constructor: () ->
    @piles = []
    @persons = []
  check_assign: () ->
    if @persons.length == 0
      return false
    return true
  drop: (map) ->
    x = @x - random_number(5) + random_number(5)
    y = @y - random_number(5) + random_number(5)
    proposal = map.propose_drop(x,y)
      if proposal != false
        return proposal