class ScenarioInitialize
  constructor: (@units,@map) ->
  create: (name) ->
    switch(name)
      when "combat"
        @units.create new Human(10,10,"Miya",1)
        @units.create new Human(10,20, "John",0)
        @units.units[0].target = @units.units[1]
        @units.units[1].stance = 1
      when "leg_disability"
        @units.create new Human(10,10, "Can'tWalk",0)
        @units.units[0].body.leg = 2
        @units.units[0].set_move(20,20)
      when "pig_invasion"
        @units.create new Lightboar(0,4, "pigboy",0)
        @units.create new Lightboar(3,3, "pigone",0)
        @units.create new Lightboar(2,3, "pigtwo",0)
        @units.create new Lightboar(20,15,"pigthree",0)
        @units.units[1].order = null
        @units.units[2].order = null
        @units.units[3].order = null
        @map.create_crystal(5,5)
        @map.drop_crystal(5,5)
      when "hand_disability_combat"
        @units.create new Human(10,10, "nofight",0)
        @units.create new Human(10,20, "Target",1)
        @units.units[0].body.hand = 2
        @units.units[0].target = @units.units[1]
      when "hand_disability_gathering"
        @units.create new Human(10,10,"gatherer",0)
        @units.units[0].body.hand = 2
        location = (x: 300, y: 300)
        @map.add_stockpile(location)
      else
        @units.create new Human(10,10, "Killy",0)
        @units.create new Human(12,10, "Cibo",1)
