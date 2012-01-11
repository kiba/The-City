
menu = (p5) ->


  p5.setup = () ->
    p5.size(800, 600)
    p5.frameRate(50)
    p5.background(0)
    @mode = 1
    @logic_manager = new ManagerManager()
    @draw_manager = new DrawManagerManager(p5)
    @key_manager = new KeyManager()

  p5.keyPressed = () ->
    p5.input_result(@key_manager.key_pressed(@manager,p5.key))

  p5.input_result = (result) ->
    @logic_manager.input(@manager,result)
    @draw_manager.input(@manager,result)
    @manager = changeManager(@manager,result)

  p5.logic = () ->
    @logic_manager.act(@manager)
    @draw_manager.draw(@manager,@logic_manager)


  p5.draw = () ->
    p5.logic()



$(document).ready ->
  canvas = document.getElementById "processing"

  processing = new Processing(canvas, menu)
