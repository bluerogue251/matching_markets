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

  possibleTransfers: ->
    otherRoles().map (otherRole) ->
      {
        cssId: "Transfer-to-#{otherRole}",
        youPayTo: "You pay to #{otherRole}",
        theyPayToYouTitle: "#{otherRole} pays to you",
        theirPayoffTitle: "#{otherRole}'s total payoff",
        fruitName: otherRole,
        data: possibleTransferData(currentRole, otherRole)
      }

currentRole = "Kiwi"

colors = ["Blue", "Purple", "Indigo", "Teal"]
fruits = ["Mango", "Peach", "Banana", "Kiwi"]

otherRoles = ->
  if currentRole in colors
    fruits
  else
    colors

possibleTransferData = (color, fruit) ->
  fruit_receives = payoffAmount(color, fruit)
  color_receives = payoffAmount(fruit, color)
  transferRate = 0.5
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

