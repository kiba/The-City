class Human extends Unit
  constructor: (x, y, name,gender) ->
    super(x, y, 1,name,gender)
    @hostility = 0
    @advance = true
    @agility = 5
  set_action: (map) ->
    return if this.act_on_queue()
    return if @body.hand == 2
    switch(@queue[@order])
      when "move_to_drop"
        object = @job.get_drop_location(map)
        choices = map.free_locations(object.x,object.y,1)
        choice = choices[random_number(choices.length)]
        if object == false
          @job = null
          @queue = []
          @perform = null
          return
        this.set_move(choice.x,choice.y)
      when "move_to_crystal"
        object = @job.nearest
        if object == null
          @job = null
          @queue = []
          @perform = null
          return
        choices = map.free_locations(object.x,object.y,1)
        choice = choices[random_number(choices.length)]
        this.set_move(choice.x,choice.y)
      when "gather_crystal"
        this.acquire_item(@job.nearest.acquire())
      when "drop_crystal"
        this.drop_item("crystal")
        map.drop_crystal(@job.drop.x,@job.drop.y)
    @perform = @order
