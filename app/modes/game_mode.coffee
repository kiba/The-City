class GameMode extends Mode
  constructor: ->
    @map = new Map(100,100)
    @map.generate()
    @units = new Units(@map)
    @menu = -1
    @mouse = new Mouse()
    @jobs = new JobsManager(@map,@units.units)
    @scenario = new ScenarioInitialize(@units,@map)
    super("game")
  act: ->
    @units.move()
    @units.clean()
    @jobs.queuing()
    @jobs.assigns()
  input: (result) ->
    super(result)
    if @state == -1
      switch(result)
        when "down"
          @map.move_camera(0,-1)
        when "up"
          @map.move_camera(0,1)
        when "right"
          @map.move_camera(-1,0)
        when "left"
          @map.move_camera(1,0)
        when "crystal"
          if @menu == 1
            @mouse.mode = 1
            @mouse.build = "crystal"
        when "report"
          @state = 0
          @minor.update()
        when "build"
          if @menu == 0
            @menu = 1
        when "menu"
          if @menu != -1
            @menu = -1
            @mouse.mode = 0
          else if @menu == -1
            @menu = 0
    (change: false)
  mouse_input: (result) ->
    if @state == -1
      @mouse.x = result.x
      @mouse.y = result.y
      @map.add_stockpile(@mouse)
  update_draw: () ->
    return (units: @units.units, map: @map, msg: @units.msg_manager.get_last_update(), state: -1, menu: @menu, mouse: @mouse) if @state == -1
    super()
