Template.sidebar.rendered = ->

  for i in [1..5]
    fview = FView.byId("m"+i)
    target = fview.surface
    target.on "click",(evt) =>
      flag = Session.get 'menupressed'
      if  flag is off
        flag = Session.set 'menupressed',true
        s = FView.byId(evt.currentTarget.classList[2])

        App.menuAnimate(s)

        if evt.currentTarget.classList[3] isnt 't_sidebar_inline'
          c = evt.currentTarget.classList[3]
          App.events.emit 'swipeleft',c

        Meteor.setTimeout ->
          Session.set 'menupressed',false
        ,500


  timerFired = (nm) ->
    s  = FView.byId("m"+nm)
    s.modifier.setTransform Famous.Transform.translate(0,0,-1),{duration: 200,ease: "easeInOut"}

  animate = ->
      for i in [1..5]
        s  = FView.byId("m"+i)
        s.modifier.setTransform Famous.Transform.translate(0,(6-i)*100,-1)
      for nm in [1..5]
        delay = nm*200
        Famous.Timer.setTimeout(timerFired.bind(this,nm),delay)

  App.events.on 'animate',=>
    animate()