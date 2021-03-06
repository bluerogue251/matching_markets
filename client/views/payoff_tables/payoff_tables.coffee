Template.payoffTables.helpers
  fruits: -> fruits
  colors: -> colors
  pageHeader: -> "You are player #{currentRole}. This is round #{roundNumber}. The transfer rate is 1 to #{transferRate}."

  payoffs: ->
    colors.map (color) ->
      {
        colorName: color,
        data: fruits.map (fruit) -> displayPayoffs(color, fruit)
      }

  possibleTransfers: ->
    otherRoles(currentRole).map (otherRole) ->
      {
        cssId: "Transfer-to-#{otherRole}",
        otherRole: otherRole,
        youPayTo: "You pay to #{otherRole}",
        theyPayToYouTitle: "#{otherRole} pays to you",
        theirPayoffTitle: "#{otherRole}'s total payoff",
        fruitName: otherRole,
        data: possibleTransferData(currentRole, otherRole)
      }

currentRole = "Kiwi"
roundNumber = 3
transferRate = 0.5

otherRoles = (role) ->
  if role in colors
    fruits
  else
    colors

possibleTransferData = (color, fruit) ->
  fruit_receives = payoffAmount(color, fruit)
  color_receives = payoffAmount(fruit, color)
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

  'click button.choose': (e) ->
    otherRole = $(e.target).closest(".modal").data("other-role")
    td = $(e.target).closest("tr")
    youPay          = parseInt(td.find(".you-pay").text())
    theyPay         = parseInt(td.find(".they-pay").text())
    fromTotalPayoff = parseInt(td.find(".your-total-payoff").text())
    toTotalPayoff   = parseInt(td.find(".their-total-payoff").text())
    offer = {
      from: currentRole,
      to: otherRole,
      fromPays: youPay,
      toPays: theyPay,
      fromTotalPayoff: fromTotalPayoff,
      toTotalPayoff: toTotalPayoff
    }
    if confirm "Make offer?"
      Meteor.call 'makeOffer', offer, (error, id) ->
        alert error.reason if error
      $('.modal').modal("hide")

