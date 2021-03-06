class floatsTracker
  constructor: () ->
    @msgs = []
    @last = 0
    @size = 0
  random_dir: () ->
    x = random_number(3) - 1
    y = random_number(3) - 1
    (x: x, y: y)
  process: (msgs) ->
    if msgs != false
      if msgs.length - 1> @last
        @last = msgs.length - 1
        @size = 0
      if msgs[@last].actions.length - 1 > @size
        @size = msgs[@last].actions.length - 1
        object = msgs[@last].actions[@size]
        priority = msgs[@last].priority[@size]
        time = 15
        if priority == 1
          time = 30
        @msgs.push new floatText(object.msg,time,object.x,object.y, this.random_dir())
