class GameMode extends Mode
  constructor: ->
    @map = new Map(100,100)
    @msgs = new MsgManager()
    @units = new Units(@map,@msgs)
    @menu = 0
    @mouse = new Mouse()
    @jobs = new JobsManager(@map,@units.units)
    @scenario = new ScenarioInitialize(@units,@map)
    @tester = new ScenarioTester(this)
    @time = new Timer()
    super("game")
  reset: () ->
    @map.reset()
    @units.reset()
    @jobs.reset()
    @scenario.run()
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
          @map.camera.move(0,-1)
        when "up"
          @map.camera.move(0,1)
        when "right"
          @map.camera.move(-1,0)
        when "left"
          @map.camera.move(1,0)
        when "crystal"
          if @menu == 1
            @mouse.mode = 1
            @mouse.build = "crystal"
        when "tree"
          if @menu == 1
            @mouse.mode = 1
            @mouse.build = "tree"
        when "report"
          @state = 0
          @minor.update()
        when "help"
          @state = 1
        when "build"
          if @menu == 0
            @menu = 1
        when "menu"
          if @menu != -1
            @menu = -1
            @mouse.mode = 0
          else if @menu == -1
            @menu = 0
        when "back"
          if @menu == 1
            @menu = 0
            @mouse.mode =  0
      @tester.input(result)
    (change: false)
  mouse_input: (result) ->
    if @state == -1
      @mouse.x = result.x
      @mouse.y = result.y
      if @mouse.mode == 1
        @map.dest.add_stockpile(@mouse)
  update_draw: () ->
    return (units: @units.units, map: @map, msg: @msgs.get_last_update(), state: -1, menu: @menu, mouse: @mouse, resource_msgs: @msgs.get_list("resource")) if @state == -1
    super()
