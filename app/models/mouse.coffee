class Mouse
  constructor: () ->
    @mode = 0
    @build = null
    @x = 0
    @y = 0
    #0 is nothing. 1 is build
  offset: (x,y) ->
    @x += x
    @y += y