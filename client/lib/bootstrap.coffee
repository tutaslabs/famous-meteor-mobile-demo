#declare namespaces
window.App ?= {}
window.Famous ?={}

Meteor.startup  ->
  Session.set 'currentHeadFootContentTemplate','page1ScrollView'
  Session.set 'currentTransitionHead', 'slideWindow'
  Session.set 'serverURL', location.origin
  Session.set 'clicked',false
  Session.set 'mhfclicked',false
  Session.set 'menupressed',false

  Logger.setLevel 'famous-views','info'
  App.ebtn = App.hbtn = false
  App.events = new Famous.EventHandler
  App.headerDefaultText = "<em>Welcome</em>"

App.menuAnimate = (fview) ->
  fview.modifier.setTransform Famous.Transform.translate(-50,0),{duration: 500,ease: "easeInOut"},=>
    fview.modifier.setTransform Famous.Transform.translate(0,0),{duration: 500,ease: "easeInOut"}