class DrawMode
  constructor:(name,p5) ->
    @minor_draw = new DrawMinorModeManager(name,p5)
  draw: (object) ->
    return if object.state == -1
    @minor_draw.draw(object.state,object)
  input: (result) ->
