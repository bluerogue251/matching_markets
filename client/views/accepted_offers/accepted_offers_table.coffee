Template.acceptedOffersTable.helpers
  fruits: -> fruits
  colors: -> colors
  acceptedOffers: ->
    colors.map (color) ->
      {
        colorName: color,
        data: fruits.map (fruit) ->
          offer = lastAcceptedOffer(color, fruit)
          offer.toTotalPayoff if offer
      }

lastAcceptedOffer = (color, fruit) ->
  Offers.findOne(to: color, from: fruit, acceptedAt: {$ne:null})
