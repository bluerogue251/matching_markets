this.Offers = new Meteor.Collection("offers")

Meteor.methods
  makeOffer: (offerAttributes) ->
    user = Meteor.user()
    offer = _.extend(_.pick(offerAttributes, 'from', 'to', 'fromPays', 'toPays', 'fromTotalPayoff', 'toTotalPayoff'), {
      madeAt: new Date().getTime()
    })
    Offers.insert(offer)

  acceptOffer: (offerId) ->
    Offers.update(offerId, {$set: { acceptedAt: new Date().getTime() }})

  rejectOffer: (offerId) ->
    Offers.update(offerId, {$set: { rejectedAt: new Date().getTime() }})
