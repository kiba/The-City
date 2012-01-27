class Map
  constructor: (width, height) ->
    @camera_x = 0
    @camera_y = 0
    @map = new Array(height)
    for h in [0..height] when h < height
      @map[h] = new Array(width)
    @stockpoints = []
  generate: ->
    for h in [0..@map.length] when h < @map.length
      for w in [0..@map[h].length] when w < @map[h].length
        if (Math.random() * 10) > 5
          @map[h][w] = new Floor()
        else
          @map[h][w] = null
    for i in [0..10] when i < 10
      x = Math.floor(Math.random() * 100)
      y = Math.floor(Math.random() * 100)
      @map[y][x] = new CrystalTree()
  result: ->
    return @map
  add_stockpile:(mouse) ->
    x = mouse.x
    y = mouse.y
    x = Math.floor(x / 20) - @camera_x
    y = Math.floor(y / 20) - @camera_y
    if @map[y][x] == null || @map[y][x].collide() == false
      if this.collision_detect(x,y) == false
        @map[y][x] = new CrystalPile(x,y)
        @stockpoints.push @map[y][x]
  collision_detect: (x,y) ->
    return false if @stockpoints.length == 0
    for pile in @stockpoints
      if circle_collision(x,y,pile) == true
        return true
    return false
  move_camera: (x,y) ->
    @camera_x += x
    @camera_y += y