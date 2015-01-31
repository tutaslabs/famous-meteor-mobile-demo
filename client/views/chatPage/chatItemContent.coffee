
Template.chatItemContent.rendered = ->
  fview = FView.from this
  fview.preventDestroy()


  t = new Famous.Transitionable 0

  fview.modifier.transformFrom =>
    currentPosition = t.get()
    return Famous.Transform.translate currentPosition,0, 0


  fview.onDestroy = ->
    fview = this

    t.set -800,{duration: 500, curve: 'easeOut'},->
      fview.destroy()
      Router.go '/chat'



Template.chatItemContent.events
  'click #ibtn':  (evt,tmpl) ->
    t = this._id
    if App.ebtn is false
      Meteor.call 'removeChat',t
      App.ebtn = true
    Meteor.setTimeout ->
      App.ebtn = false
    ,500

