class DrawMode
  constructor: (@p5) ->
    @modes = initializeDrawModes(@p5)
  draw: (n, logic) ->
    @modes[n].draw(logic.update_draw(n))
  input: (n, result) ->
    @modes[n].input(result)