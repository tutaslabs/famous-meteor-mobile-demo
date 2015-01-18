Template.sidebar3.rendered = ->

  flag = off
  #loop through our 5 menu items and add click event processing code
  for i in [1..5]
    fview = FView.byId("m"+i)
    target = fview.surface
    target.on "click",(evt) =>
      if  flag is off   #double click iOS bug protection
        flag = on
        #this is where we cheat and get the item name from our class list 'sidebar m[1-4] templatename'
        #refer to the code above to see the class parameters again. Famous inserts a class entry at
        #the beginning and end of our list. That's why we are getting the third element (classList[2])
        #of the array. Remember arrays start indexing at 0.

        s = FView.byId(evt.currentTarget.classList[2])

        # we animate the menu item by moving it to the left 50 pixels and when that has completed
        # we move it back to it's original position via a completion callback
        s.modifier.setTransform Famous.Transform.translate(-50,0),{duration: 500},=>
          s.modifier.setTransform Famous.Transform.translate(0,0),{duration: 500}

        Meteor.setTimeout ->
          flag = off
        ,500

  ###### this starts the animation code
  # we will be using a staggered, variable delay timer and transform.translate
  # to move the items into position

  #move the surfaces to their original position (0,0) defined at creation time
  #take .2 seconds to complete the transition

  timerFired = (nm) ->
    s  = FView.byId("m"+nm)
    s.modifier.setTransform Famous.Transform.translate(0,0,-1),{duration: 200}

  # this is the event listener callback that will get called whenever
  # an 'animate' event is received
  App.events.on 'animate',=>
    # loop through all of our menu item surfaces and stack them together
    # below the sidebar container view
    # our sidebar has a FIXED length of 500px. So the upper item has to
    # move down further (600px) than the lowest item (100px)
    # if you add items and make the sidebar longer - chg the formula
    # Notice: there is no duration specified so the move is instantaneous!
    for i in [1..5]
      s  = FView.byId("m"+i)
      s.modifier.setTransform Famous.Transform.translate(0,(6-i)*100,-1)
    # move the items back to their original positions using a timer that
    # varies based on the distance the item has to move. The top item
    # takes .2 seconds and every item below it adds .2 seconds.
    # this is based on the .2 second transition duration specified above
    # and allows the transition of one item to finish before starting the next one
    # this provides a natural (non-overlapping) visual look to the animation
    for nm in [1..5]
      delay = nm*200
      #this is the timer function where we pass a callback and delay
      #the callback use of bind allows us to call a function external
      #to the timer and maintain correct scoping
      #don't worry - this is the only place in the code that you will
      #see this advanced javascript weirdness!
      Famous.Timer.setTimeout(timerFired.bind(this,nm),delay)
