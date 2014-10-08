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

  colorToFruitTransfers: -> [
    {
      cssId: "Transfer-to-Mango",
      youPayTo: "You pay to Mango",
      theyPayToYouTitle: "Mango pays to you",
      theirPayoffTitle: "Mango's total payoff",
      fruitName: "Mango",
      data: colorFruitTransfers(currentRole, "Mango")
    },
    {
      cssId: "Transfer-to-Peach",
      youPayTo: "You pay to Peach",
      theyPayToYouTitle: "Peach pays to you",
      theirPayoffTitle: "Peach's total payoff",
      fruitName: "Peach",
      data: colorFruitTransfers(currentRole, "Peach")
    },
    {
      cssId: "Transfer-to-Banana",
      youPayTo: "You pay to Banana",
      theyPayToYouTitle: "Banana pays to you",
      theirPayoffTitle: "Banana's total payoff",
      fruitName: "Banana",
      data: colorFruitTransfers(currentRole, "Banana")
    },
    {
      cssId: "Transfer-to-Kiwi",
      youPayTo: "You pay to Kiwi",
      theyPayToYouTitle: "Kiwi pays to you",
      theirPayoffTitle: "Kiwi's total payoff",
      fruitName: "Kiwi",
      data: colorFruitTransfers(currentRole, "Kiwi")
    }
  ]

currentRole = "Blue"

colorFruitTransfers = (color, fruit) ->
  payoff = findPayoff(color, fruit)
  transferRate = 0.5
  color_receives = payoff.colorReceives
  fruit_receives = payoff.fruitReceives
  array = []
  [color_receives..1].map (num) ->
    array.push({youPay: num, yourTotalPayoff: color_receives - num, theirTotalPayoff: fruit_receives + (num * transferRate) })
  array.push({youPay: 0, yourTotalPayoff: color_receives, theirTotalPayoff: fruit_receives, theyPay: 0 })
  [1..fruit_receives].map (num) ->
    array.push({theyPay: num, theirTotalPayoff: fruit_receives - num, yourTotalPayoff: color_receives + (num * transferRate) })
  array

displayPayoff = (color, fruit) ->
  payoff = findPayoff(color, fruit)
  payoff.colorReceives + ', ' + payoff.fruitReceives

findPayoff = (color, fruit) ->
  Payoffs.findOne(color: color, fruit: fruit)

Template.payoffTables.events
  'click th': (e) ->
    clickedOnUser = $(e.target).text()
    $("#Transfer-to-#{clickedOnUser}").modal()

