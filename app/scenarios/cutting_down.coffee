cuttingDown = (units,map) ->
  map.sketch.create("tree",10,10)
  units.create new Human(20,10, "logger", 1)
  units.create new Human(25,10, "gatherer",0)
  map.dest.add_stockpile(x: 400, y: 100, build: "tree")
  map.select_last(10,10).dir = "left"
  map.sketch.create("tree",10,5)
  map.select_last(10,5).dir = "down"