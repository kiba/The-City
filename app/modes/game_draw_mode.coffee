class GameDrawMode extends DrawMode
  constructor:(@p5) ->
    @map_draw = new mapDraw(@p5)
    @dirty_rects = []
    super("game",@p5)
  draw: (object) ->
    switch (object.state)
      when -1
        map = object.map
        @map_draw.draw(@dirty_rects,map)
        units = object.units
        msg = object.msg
        unitDraw(units,map,@p5)
        if object.menu != -1
          menuDraw(@p5)
        switch(object.menu)
          when 0
            gameMenuDraw(@p5)
          when 1
            buildMenuDraw(@p5)
        if msg != -1
          messageDraw(@p5,msg)
        mouseDraw(@p5,object.mouse,map.camera_x,map.camera_y)
        @dirty_rects = []
        for unit in units
          @dirty_rect.push(x: unit.x, y: unit.y)
      when 0
        super(object)

  input: (result) ->
    super(result)
