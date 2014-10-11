Template.payoffTables.helpers
  blueMango: ->  displayPayoffs("Blue", "Mango")
  bluePeach: ->  displayPayoffs("Blue", "Peach")
  blueBanana: -> displayPayoffs("Blue", "Banana")
  blueKiwi: ->   displayPayoffs("Blue", "Kiwi")

  purpleMango: ->  displayPayoffs("Purple", "Mango")
  purplePeach: ->  displayPayoffs("Purple", "Peach")
  purpleBanana: -> displayPayoffs("Purple", "Banana")
  purpleKiwi: ->   displayPayoffs("Purple", "Kiwi")

  indigoMango: ->  displayPayoffs("Indigo", "Mango")
  indigoPeach: ->  displayPayoffs("Indigo", "Peach")
  indigoBanana: -> displayPayoffs("Indigo", "Banana")
  indigoKiwi: ->   displayPayoffs("Indigo", "Kiwi")

  tealMango: ->  displayPayoffs("Teal", "Mango")
  tealPeach: ->  displayPayoffs("Teal", "Peach")
  tealBanana: -> displayPayoffs("Teal", "Banana")
  tealKiwi: ->   displayPayoffs("Teal", "Kiwi")

  possibleTransfers: -> [
    {
      cssId: "Transfer-to-Mango",
      youPayTo: "You pay to Mango",
      theyPayToYouTitle: "Mango pays to you",
      theirPayoffTitle: "Mango's total payoff",
      fruitName: "Mango",
      data: possibleTransferData(currentRole, "Mango")
    },
    {
      cssId: "Transfer-to-Peach",
      youPayTo: "You pay to Peach",
      theyPayToYouTitle: "Peach pays to you",
      theirPayoffTitle: "Peach's total payoff",
      fruitName: "Peach",
      data: possibleTransferData(currentRole, "Peach")
    },
    {
      cssId: "Transfer-to-Banana",
      youPayTo: "You pay to Banana",
      theyPayToYouTitle: "Banana pays to you",
      theirPayoffTitle: "Banana's total payoff",
      fruitName: "Banana",
      data: possibleTransferData(currentRole, "Banana")
    },
    {
      cssId: "Transfer-to-Kiwi",
      youPayTo: "You pay to Kiwi",
      theyPayToYouTitle: "Kiwi pays to you",
      theirPayoffTitle: "Kiwi's total payoff",
      fruitName: "Kiwi",
      data: possibleTransferData(currentRole, "Kiwi")
    },
    {
      cssId: "Transfer-to-Blue",
      youPayTo: "You pay to Blue",
      theyPayToYouTitle: "Blue pays to you",
      theirPayoffTitle: "Blue's total payoff",
      fruitName: "Blue",
      data: possibleTransferData(currentRole, "Blue")
    },
    {
      cssId: "Transfer-to-Purple",
      youPayTo: "You pay to Purple",
      theyPayToYouTitle: "Purple pays to you",
      theirPayoffTitle: "Purple's total payoff",
      fruitName: "Purple",
      data: possibleTransferData(currentRole, "Purple")
    },
    {
      cssId: "Transfer-to-Indigo",
      youPayTo: "You pay to Indigo",
      theyPayToYouTitle: "Indigo pays to you",
      theirPayoffTitle: "Indigo's total payoff",
      fruitName: "Indigo",
      data: possibleTransferData(currentRole, "Indigo")
    },
    {
      cssId: "Transfer-to-Teal",
      youPayTo: "You pay to Teal",
      theyPayToYouTitle: "Teal pays to you",
      theirPayoffTitle: "Teal's total payoff",
      fruitName: "Teal",
      data: possibleTransferData(currentRole, "Teal")
    }
  ]

currentRole = "Blue"

colors = ["Blue", "Purple", "Indigo", "Teal"]
fruits = ["Mango", "Peach", "Banana", "Kiwi"]

otherRoles = ->
  if currentRole in colors
    fruits
  else
    colors

console.log otherRoles()

possibleTransferData = (color, fruit) ->
  cToFPayoff = findPayoff(color, fruit)
  fToCPayoff = findPayoff(color, fruit)
  transferRate = 0.5
  color_receives = fToCPayoff.amount
  fruit_receives = cToFPayoff.amount
  array = []
  [color_receives..1].map (num) ->
    array.push({youPay: num, yourTotalPayoff: color_receives - num, theirTotalPayoff: fruit_receives + (num * transferRate) })
  array.push({youPay: 0, yourTotalPayoff: color_receives, theirTotalPayoff: fruit_receives, theyPay: 0 })
  [1..fruit_receives].map (num) ->
    array.push({theyPay: num, theirTotalPayoff: fruit_receives - num, yourTotalPayoff: color_receives + (num * transferRate) })
  array

displayPayoffs = (color, fruit) ->
  payoffAmount(color, fruit) + ', ' + payoffAmount(fruit, color)

findPayoff = (from, to) ->
  Payoffs.findOne(from: from, to: to)

payoffAmount = (from, to) ->
  findPayoff(from, to).amount

Template.payoffTables.events
  'click #payoff-table th': (e) ->
    clickedOnUser = $(e.target).text()
    $("#Transfer-to-#{clickedOnUser}").modal()

