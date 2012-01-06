class mapDraw
  constructor: (@p5,@map,@width, @height) ->

  draw: () ->
    results = @map.map
    @p5.stroke(255)
    for height in [0..@height] when height < @height
      for width in [0..@width] when width < @width
        if results[height][width] == 1
          @p5.noFill()
        else
          @p5.fill()
        @p5.rect(20 * (width + @map.camera_x),20 * (height + @map.camera_y),20,20)
