class JobsManager
  constructor: (@map,@units) ->
    @queue = []
  assigns: () ->
    return -1 if @queue.length == 0
    for u in @units
      if u.job == null
        u.set_job(@queue[0])
        u.order = 0
        @queue[0].persons.push(u)
        @queue.shift()
        if @queue.length == 0
          break
  queuing: () ->
    for s in @map.stockpoints
      if s.check_assign() == false
        i = 0
        length = @queue.length
        for q in @queue
          if q.priority < s.priority
            @queue.splice(i,0,s)
            i += 1
        if @queue.length == length
          @queue.push(s)