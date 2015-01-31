Template.lessonOne.rendered = ->

  flag = off #double click protection
  slideDuration = 300 #how fast we want the animation to be - in milliseconds

  #create a transitionable so we can animate our header/footer view
  hfl = new Famous.Transitionable 0 #initialize to 0

  #get the header/footer layout view so we can attach a transformFrom to it's modifier
  #we gave it an id of 'hfl' above when we created it.
  fview = FView.byId 'hfl'

  # animate the header-footer-layout view using a transitionable value
  # remember that our transformFrom callback function will be running at 60FPS!
  # The transitionable will be used to move the view from the far left (original position)
  # to the right for a distance of 70% of the current window width.
  #
  # Remember the Transform.translate X and Y coordinates are relative to the 'original' position of
  # the renderable. Not absolute screen coordinates.
  # So 0,0 is the original position at creation time.
  # A minus X value would move it to the left (even off the screen). Positive X values move it to
  # right. And a value of zero returns it to its original position.
  fview.modifier.transformFrom =>
    currentPosition = hfl.get()
    return Famous.Transform.translate(currentPosition,0, 0)

  # monitor mouse and touch events in the X direction only
  # A sync is basically just a filter. We tell it what type of events we want to respond to
  # The GenericSync is a way to listen to multiple event sources such as mouse and touch
  # Famo.us can respond to a lot of touch events, such as pinching, multi-finger, swiping, dragging
  # So we want to create a sync that responds to mouse (for PC), touch (mobile,tablet,etc)
  # and we are only interested in changes in the X direction (left and right). We can use our new
  # sync object to notify us of 'start','end', and 'update' events (to name a few).

  sync = new Famous.GenericSync ['mouse','touch'],
    {direction: Famous.GenericSync.DIRECTION_X}

  # capture events for the entire window  - the use of PIPES
  # we have to get our events from somewhere and this is where piping comes into play
  # for testing we are going to capture all events on our window by using the
  # Famous.Engine which watches EVERYTHING going on. So the next line tells the Engine to send
  # (pipe) all events to our GenericSync (sync)
  Famous.Engine.pipe sync   #testing only - remove later

  #this is just checking for a mouse up or drag/touch ending
  #we are not doing real time sliding via 'update' callback

  sync.on 'end', =>
    if flag is off              #no click pending - ok to proceed
      flag = on                 #prevent processing of rapid double clicks bug on iOS
      #check to see if panel is all the way to the left
      if hfl.get() is 0
        #move panel to 70% of screen width to the right - animate it
        #(this is a pixel offset from align) no easing!
        hfl.set window.innerWidth - (window.innerWidth*.30),{duration: slideDuration}
        #move the backing surface 'back' under the sidebar menu
        #so the menu can be visible (chg z index)
        FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-10)

      else
        #animate back to the left (0 offset from original x align value)
        hfl.set 0,{duration: slideDuration},=>
          #bring the backing over the sidebar to hide it -
          #could have just 'hid' the sidebar with CSS
          #this is a callback executed after transition
          FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-2)
      #clear click flag after 200 milliseconds so we can process more real clicks
      Meteor.setTimeout ->
        flag = off
      ,200