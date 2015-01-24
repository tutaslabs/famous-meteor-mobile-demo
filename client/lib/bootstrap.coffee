#declare namespaces
window.App ?= {}
window.Famous ?={}


Meteor.startup  ->
  Logger.setLevel 'famous-views','info'
  App.events = new Famous.EventHandler

  # create a variable in our App namespace (so coffeescript can get to it)
  # that defines the type of transition we want the rendercontroller to use
  # note: this is a famous-views specific definition for sliding left
  App.transitionContent =  'slideWindow'

  # set the Session variable that will tell the rendercontroller which template
  # to render. All reactive ! We will be rendering ScrollViews as our content
  Session.set 'currentHeadFootContentTemplate','homeScrollView'

  # get our server URL so we can make a REST call to it
  Session.set 'serverURL', location.origin
  Session.set 'design','I am using nothing'
  Meteor.subscribe 'chat'
  App.ebtn = false
