class Mode
  constructor:(name,p5) ->
    @minor = new MinorModeManager(name)
    @minor_draw = new MinorDrawModeManager(name,p5)
  act: () ->
    @minor.act()
  input: (result) ->
    @minor.input(result)
  update_draw: () ->
    @minor.update_draw()
