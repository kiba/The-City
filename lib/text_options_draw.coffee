class TextOptionsDraw
  constructor: (@p5,@x,@y,@size) ->
    @offset_y = 0
  draw: (texts,pointer) ->
    @p5.textFont("Monospace",@size)
    y = @y + @offset_y
    @offset_y = 0
    for data in texts
      @p5.text(data,@x,y)
      y += @size
    pointer_y = @y + (pointer * @size)
    @p5.ellipse(@x - 20,pointer_y - (@size / 2),10,10) if texts.length > 0
