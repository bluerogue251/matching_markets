this.Offers = new Meteor.Collection("offers")

Meteor.methods
  makeOffer: (offerAttributes) ->
    user = Meteor.user()
    offer = _.extend(_.pick(offerAttributes, 'from', 'to', 'fromPays', 'toPays', 'fromTotalPayoff', 'toTotalPayoff'), {
      madeAt: new Date().getTime()
    })
    Offers.insert(offer)

