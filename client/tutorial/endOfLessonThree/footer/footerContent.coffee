Template.footerContent3.rendered = ->
# our 'home' button - was created as hidden in the template
  fview = FView.byId 'b1'
  button = fview.surface
  button.on "click", =>
    # tell anyone listening that a display of the
    # 'home' page has been requested by the user
    App.events.emit 'swipeleft','home'
    # we can dynamically add/remove classes to our surfaces
    # the 'hide' class is just a 'display: none;' in the CSS
    # we are going 'home' so don't display the 'home' button
    button.addClass 'hide'

  # another function in our app can notify us when the
  # panel is moving back to the left to display page content
  # if we are going to a page other than the 'home' page
  # display the 'home' button in the footer to allow the user
  # to return home
  App.events.on 'swipeleft',(c) ->
    # remember we can send 'data' with our events
    if c isnt 'home'
      button.removeClass 'hide'