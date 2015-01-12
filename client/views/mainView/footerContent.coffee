Template.footerContent.rendered = ->

  fview = FView.byId 'b1'
  target = fview.surface
  target.on "click", =>
    App.events.emit 'swipeleft','page1'
