cuttingDown = (units,map) ->
  map.sketch.create("tree",10,10)
  units.create new Human(20,10, "logger", 1)
  map.dest.add_stockpile(x: 400, y: 100, build: "tree")