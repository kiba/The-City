class MenuMode
  constructor:() ->
    @options = new TextOptions()
    @options = ["New Game", "Test Arena"]

  act:() ->
  input: (result) ->
  update_draw: (n) ->
    return -1
