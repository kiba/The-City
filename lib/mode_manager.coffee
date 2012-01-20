class ModeManager
  constructor: ->
    @modes = initializeModes()
  act: (n) ->
    @modes[n].act()
  input: (n,result) ->
    @modes[n].input(result)
  update_draw: (n) ->
    return @modes[n].update_draw()
  update_mode: (n) ->
    return @modes[n].update_mode(n)