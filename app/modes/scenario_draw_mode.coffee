class ScenarioDrawMode extends DrawMode
  constructor: (@p5) ->
    @texts = new TextOptionsDraw(@p5,30,12,12)
  draw: (object) ->
    @p5.background(0)
    @texts.draw(object.options,object.pointer)
    instructionDraw(@p5)
  input: (result) ->