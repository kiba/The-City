class CrystalPile extends Stockpile
  constructor: (@x,@y,@tree) ->
    super()
    @name = "CrystalPile"
    @persons = []
    @priority = 4
    @diameter = 5
    @size = 10
    @queue = false
    @orders = ["crystal_move","crystal_gather","move_to_drop","crystal_drop"]
    @nearest = null
  collide: () ->
    return true
  check_assign: () ->
    if @persons.length == 0
      return false
    return true
  set_drop: () ->