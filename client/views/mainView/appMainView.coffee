

Template.appMainView.rendered = ->
#pull the view up then animate down when finished
#happens so fast appears to be animating down only
  Meteor.subscribe 'chat'
  App.hfl = new Famous.Transitionable 0
#so menu doesn't show on background when scrolling
  FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-2)
  fview = FView.byId 'hfl'

  fhl = FView.byId('headl').surface
  fht = FView.byId('headt').surface
  fhr = FView.byId('headr').surface

  fview.modifier.transformFrom =>
    currentPosition = App.hfl.get()
    return Famous.Transform.translate(currentPosition,0, 0)


  sync = new Famous.GenericSync ['mouse','touch'],{direction: Famous.GenericSync.DIRECTION_X}
#  'Famous.Engine.pipe sync' would be used to catch events for entire window
#  we are only interested in the following surfaces
  fhl.pipe sync
  fht.pipe sync
  fhr.pipe sync



#this is just checking for a mouse/drag up/stop  - we are not doing real time sliding via update
  sync.on 'end', =>
    flag = Session.get 'mhfclicked'
    if  flag is off
      Session.set 'mhfclicked',true
      if App.hfl.get() is 0
        App.hfl.set window.innerWidth - (window.innerWidth*.30),{duration: 500,ease: "easeInOut"}
        FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-10)
        fhr.setContent '<<'
        fhr.addClass 'headArrows'
        App.events.emit 'animate'
      else
        gc = fht.getContent()
        if typeof gc is 'object'
          gc = gc.innerText
        if gc is 'Page1'
          fhr.setContent App.headerDefaultText
        else
          fhr.setContent 'Enjoy'

        fhr.removeClass 'headArrows'
        App.hfl.set 0,{duration: 500,ease: "easeInOut"}
        Meteor.setTimeout ->
          FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-2)
        ,600
      Meteor.setTimeout ->
        Session.set 'mhfclicked',false
      ,500

  App.events.on 'swipeleft', (page) =>
    if page isnt 'page1'
      fhr.setContent 'Enjoy'
    else
      fhr.setContent App.headerDefaultText
    fht.setContent page.charAt(0).toUpperCase() + page.slice(1)
    fhr.removeClass 'headArrows'
    display page

  display = (page) ->
    App.hfl.set 0,{duration: 500,ease: "easeInOut"},=>
      Session.set 'currentHeadFootContentTemplate',page+'ScrollView'
    Meteor.setTimeout ->
      FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-2)
    ,600