Template.rcHeadFootContent.helpers
  'showTemplate': ->
    Template[this.name]
  'getTransition': ->
    Session.get 'currentTransitionHead'
Template.rcHeadFootContent.currentTemplate = ->
  Session.get 'currentHeadFootContentTemplate'
