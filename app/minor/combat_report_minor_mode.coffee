class CombatReportMinorMode
  constructor:(@parent) ->
    @msg = []
    @relations = @parent.units.msg_manager.relations
  act: ->
  input: (result) ->
  input_info: (@msg) ->
  update_draw: () ->
    return 0
