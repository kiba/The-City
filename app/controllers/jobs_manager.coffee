class JobsManager
  constructor: (@map,@units) ->
    this.setup()
  setup: () ->
    @queue = []
  assigns: () ->
    return -1 if @queue.length == 0
    for u in @units
      if u.job == null
        u.set_job(@map.stockpoints[@queue[0]])
        u.order = 0
        @map.stockpoints[@queue[0]].persons.push(u)
        @queue.shift()
        if @queue.length == 0
          break
  queuing: () ->
    count = 0
    @queue = []
    for s in @map.stockpoints
      if s.check_assign() == false && s.finish == false
        i = 0
        length = @queue.length
        for q in @queue
          if q.priority < s.priority
            @queue.splice(i,0,count)
            i += 1
        if @queue.length == length
          @queue.push(count)
      count += 1
  reset: () ->
    this.setup()