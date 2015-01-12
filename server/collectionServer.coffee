
Chat.allow
    insert: (userId, doc) ->
      return true
    update: (userId, doc, fields, modifier) ->
      return false
    remove: (userId, doc) ->
      return false

Meteor.publish 'chat', ->
  Chat.find()
