class MapSketch
  constructor: (@map) ->
    @finder = new Pathfinder(@map)
    @last = null
  create_wall: (x, y) ->
    wall = new Wall(x,y)
    this.push_to_map(x,y,wall)
  create_tree: (x, y) ->
    tree = new Tree(x,y)
    if this.push_to_map(x,y,tree) == true
      @map.trees.push(tree)
      return true
    false
  create_crystal_tree: (x, y) ->
    tree = new CrystalTree(x,y)
    if this.push_to_map(x,y,tree) == true
      @map.crystal_trees.push(tree)
      return true
    false
  create_wood: (x,y) ->
    wood = new Wood(x,y)
    wood.stack = @map.map[y][x].length
    if this.push_to_map(x,y,wood) == true
      @map.woods.push(wood)
    return wood
  create_crystal: (x,y) ->
    crystal = new Crystal(x,y)
    crystal.stack = @map.map[y][x].length
    if this.push_to_map(x,y,crystal) == true
      @map.crystals.push(crystal)
    return crystal
  push_to_map: (x,y,item) ->
    if @map.collision.create_check(x,y,item) == true
      @map.map[y][x].push(item)
      return true
    false
  create_floor: (x,y) ->
    floor = new Floor(x,y)
    this.push_to_map(x,y,floor)
    floor
  rect_draw: (begin,end,type) ->
    for x in [begin.x..end.x]
      for y in [begin.y..end.y]
        this.draw_location((x: x, y: y),type)
  pathing: (point_a,point_b) ->
    results = @finder.calculate_path(point_a,point_b)
    if results != -1
      results.push(point_a) #since starting positions aren't pushed in pathfinder
    results
  draw_location: (location,type,thicken = false) ->
    switch(type)
      when "wall"
        this.create_wall(location.x,location.y)
      when "crystal"
        this.create_crystal(location.x,location.y)
      when "floor"
        @last = this.create_floor(location.x,location.y)
        if thicken == true
          this.create_floor(@last.x - 1,@last.y)
          this.create_floor(@last.x,@last.y - 1)
  draw: (point_a,point_b,type,thicken) ->
    results = this.pathing(point_a,point_b)
    for location in results
      this.draw_location(location,type,thicken)
    @last = null
  delete: (x,y,type) ->
    n = 0
    for m in @map.map[y][x]
      if m.name == type
        break
      n += 1
    @map.map[y][x].splice(n,1)
  cut_down: (x,y,d) ->
    object = @map.select_by_name("tree",x,y)
    unless object == false
      for i in [0..4]
        this.create_log(x,y)
        x += d.x
        y += d.y