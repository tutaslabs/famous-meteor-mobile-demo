Template.chatFoot.rendered = ->
  fview = FView.byId 'hb'
  target = fview.surface
  target.on "click",(evt) =>
    Session.set 'currentHeadFootContentTemplate','homeScrollView'
    Router.go '/'
