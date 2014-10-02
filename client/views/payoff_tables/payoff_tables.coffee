Template.payoffTables.helpers
  blueMango: ->  displayPayoff("Blue", "Mango")
  bluePeach: ->  displayPayoff("Blue", "Peach")
  blueBanana: -> displayPayoff("Blue", "Banana")
  blueKiwi: ->   displayPayoff("Blue", "Kiwi")

  purpleMango: ->  displayPayoff("Purple", "Mango")
  purplePeach: ->  displayPayoff("Purple", "Peach")
  purpleBanana: -> displayPayoff("Purple", "Banana")
  purpleKiwi: ->   displayPayoff("Purple", "Kiwi")

  indigoMango: ->  displayPayoff("Indigo", "Mango")
  indigoPeach: ->  displayPayoff("Indigo", "Peach")
  indigoBanana: -> displayPayoff("Indigo", "Banana")
  indigoKiwi: ->   displayPayoff("Indigo", "Kiwi")

  tealMango: ->  displayPayoff("Teal", "Mango")
  tealPeach: ->  displayPayoff("Teal", "Peach")
  tealBanana: -> displayPayoff("Teal", "Banana")
  tealKiwi: ->   displayPayoff("Teal", "Kiwi")

displayPayoff = (color, fruit) ->
  payoff = Payoffs.findOne(color: color, fruit: fruit)
  payoff.colorReceives + ', ' + payoff.fruitReceives

