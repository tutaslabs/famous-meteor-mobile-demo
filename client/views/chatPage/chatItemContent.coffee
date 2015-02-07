
# This code gets executed for each chat entry displayed
Template.chatItemContent.rendered = ->
  App.ebtn = false

  # get the entry fview so we can hook into the onDestroy and do our animation
  fview = FView.from this

  # create a transitionable and use it to animate (position) our surface, initial value is 0
  t = new Famous.Transitionable 0
  # the x position of the surface will come dynamically from the transitionable at 60FPS
  fview.modifier.transformFrom =>
    currentPosition = t.get()
    return Famous.Transform.translate currentPosition,0, 0 # y and z don't change

  # tell the fview not to destroy itself automatically when entry is deleted
  fview.preventDestroy()
  # our callback onDestroy hook
  fview.onDestroy = ->
    fview = this
    # animate the surface 800 pixels to the left for half a second
    # force a destroy when the animation completes (via callback)
    t.set -800,{duration: 500, curve: 'easeOut'},->
      fview.destroy()

# our DEL button click handler code implemented as a meteor event hook

Template.chatItemContent.events
  'click #ibtn':  (evt,tmpl) ->
    # meteor goodness here - the data passed to the template for rendering is passed to us in 'this'
    # so we have access to the unique chat ID value of the entry
    t = this._id
    if App.ebtn is false    #iOS double click protection crap
      # call the server to do the actual deleting of the record (no latency compensation!)
      # refer back to the server code above to see the Meteor Method defined
      Meteor.call 'removeChat',t,(err) =>
        if err
          alert err.reason.reason  # display human readable error if it occurs
      App.ebtn = true
    Meteor.setTimeout ->
      App.ebtn = false
    ,500