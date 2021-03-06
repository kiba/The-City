determineRectDraw = (location,x,y,p5) ->
  switch(location.name)
    when "floor"
      floorDraw(p5,x,y)
    when "crystal_tree" #Crystal tree
      crystalTreeDraw(p5,x,y)
    when "crystal_stockpile" #Crystal stockpile
      return (x: x, y: y)
    when "crystal"
      crystalDraw(p5,x,y,location.items,location.background)
    when "wall"
      wallDraw(p5,x,y)
    when "debug"
      debug_draw(p5,x,y)
    when "tree"
      treeDraw(p5,x,y)
    when "timber_stockpile"
      timberStockpileDraw(p5,x,y)
    when "stone_stockpile"
      stoneStockpileDraw(p5,x,y)
    when "stone"
      stoneDraw(p5,x,y)
    when "timber"
      timberDraw(p5,x,y)
    when "log"
      logDraw(p5,x,y,location.dir,location.part)
  return true
