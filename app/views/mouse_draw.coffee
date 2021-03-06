mouseDraw = (@p5,mouse,units,map) ->
  x = Math.floor(@p5.mouseX / 20)
  y = Math.floor(@p5.mouseY / 20)
  width = 0
  item = false
  switch(mouse.mode)
    when 0 #what is it
      cam_x = x + map.camera.x
      cam_y = y + map.camera.y

      for u in units
        if u.x == cam_x && u.y == cam_y
          item = u
          break
      item = map.select_last(x + map.camera.x,y + map.camera.y) unless item != false
      msg = item.name
      unless item == false
        @p5.noStroke()
        @p5.fill(255,0,0)
        #compensate for underscore being too low by fudging by -3
        if item.name == "crystal" || item.name == "timber"
          msg = item.name + " : " + item.items
        msg += " (" + cam_x + "," + cam_y + ")"
    when 1 #build
      build_rect(@p5,x,y)
      if mouse.build == "crystal"
        msg = "Crystal Pile"
      else
        msg = "Wood Pile"
  @p5.text(msg,x * 20,y * 20 - 3)
  # width = @p5.textWidth(msg)
  # @p5.textWidth seems to be incredibly inaccurate
  Math.ceil(width / 20)