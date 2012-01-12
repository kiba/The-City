class Unit
  constructor: (@x, @y, @name, @type) ->
    @goal_x = @x
    @goal_y = @y
    @body = new Body(@type)
    @hostility = 0  #0 is friendly. 1 is hostile
    @alive = 1 #1 is alive, 0 is dead.
    @msg = []
    @target = null
  set_move: (x,y) ->
    @goal_x = x
    @goal_y = y
  move: () ->
    if (@x - @goal_x) < 0
      @x = @x + 1
      return
    else if (@x - @goal_x) > 0
      @x = @x - 1
      return
    if (@y - @goal_y) < 0
      @y = @y + 1
      return
    else if (@y - @goal_y) > 0
      @y = @y - 1
      return
  attack_chance: () ->
    @goal_x = @target.x - 1
    @goal_y = @target.y - 1
    if (@target.x + 1) == @x || (@target.x - 1) == @x
      if (@target.y + 1) == @y || (@target.y - 1) == @y
        if (Math.random() * 10) > 5
          return true
    return false
  attack: () ->
    return if @target == null || !@body.check_combat_ability()
    if this.attack_chance()
      @target.damage(this)
  nullify_target: () ->
    return if @target == null
    if @target.body.check_death() == true
      target = @target
      @target = null
      return (actors: [self.name,taget.name],action: "killed")
  damage: (unit) ->
    part = Math.floor(Math.random() * @body.parts.length)
    damage = @body.parts[part].interact()
    switch damage.type
      when 0
        return (actors:[unit.name,@name],part: damage.msg )
      when 1
        @body.death = 1
        @msg.push(@name + " dies of " + damage.msg)
      when 2
        switch @body.update_ability(damage.damage)
          when "hand"
            @msg.push(@name + " suffers hand damage!")
          when "hand_destroy"
            @msg.push(@name + " 's lost all hands function")
          when "leg"
            @msg.push(@name + " suffers leg damage!")


   get_msg: () ->
     msg = @msg
     @msg = []
     return msg