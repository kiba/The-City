class Map
  constructor: (@width, @height) ->
    this.setup()
  setup: () ->
    @map = []
    this.size_map()
    @stockpoints = []
    @crystals = []
    @timbers = []
    @logs = []
    @crystalTrees = []
    @trees = []
    @collision = new Collision(this)
    @sketch = new MapSketch(this)
    @generate = new GenerateMap(this)
    @dest = new MapDestinate(this)
    @camera = new Camera()
    @redraw = []
  size_map: () ->
    for y in [0..@height - 1]
      @map.push(new Array(@width))
      for x in [0..@width - 1]
        @map[y][x] = []

  items_total: () ->
    items = 0
    for c in @crystals
     items += @map[c.y][c.x][c.stack].items
    items
  drop_item: (x,y,item) ->
    for m in @map[y][x]
      if m.name == item
        @redraw.push(x: x, y: y)
        if m.increase() == false
          return false
        return true
    @redraw.push(x: x, y: y)
    @sketch.create(item,x,y)
    true
  new_object: (x,y) ->
    @redraw.push(x: x, y: y)
  rect_inbound: (rect) ->
    return false if !@collision.inbound(rect.x,rect.y)
    return false if !@collision.inbound(rect.x + rect.width,rect.y)
    return false if !@collision.inbound(rect.x,rect.y + rect.y + rect.height)
    true

  stockpoints_collision_detect: (newpoint) ->
    return false if @stockpoints.length == 0
    for point in @stockpoints
      if circle_to_circle_collision(newpoint,point) == true #It's not actually a circle anymore
        return true
    return false
  select_by_name: (name,x,y) ->
    for m in @map[y][x]
      if m.name == name
        return m
    false
  free_locations: (x,y,size) ->
    end_x = x + size
    begin_x = x - size
    end_y = y + size
    x = begin_x
    y -= size
    locations = []
    loop
      if x > end_x
        x = begin_x
        y += 1
        if y > end_y
          break
      if @collision.propose_drop(x,y) == true
        locations.push((x: x,y: y))
      x += 1
    return locations
  acquire: (x,y) ->
    this.select_by_name("crystal",x,y).acquire()
  select_last: (x,y) ->
    unless @map[y][x].length == 0
      l = @map[y][x].length - 1
      return @map[y][x][l]
    false
  reset: () ->
    this.setup()
  decide_list: (which) ->
    switch(which)
      when "tree"
        return @trees
      when "crystal"
        return @crystalTrees
      when "log"
        return @logs
      when "timber"
        return @timbers