Template.offer.helpers
  textDescription: -> "#{this.to} receives #{this.toTotalPayoff}. #{this.from} receives #{this.fromTotalPayoff}. Accepted at #{this.acceptedAt}. Rejected at #{this.rejectedAt}"

Template.offer.events
  'click .accept': (e) ->
    offerId = this._id
    if confirm "Accept offer #{offerId}?"
      Meteor.call 'acceptOffer', offerId, (error, id) ->
        alert error.reason if error

  'click .reject': (e) ->
    offerId = this._id
    if confirm "Reject offer #{offerId}?"
      Meteor.call 'rejectOffer', offerId, (error, id) ->
        alert error.reason if error

