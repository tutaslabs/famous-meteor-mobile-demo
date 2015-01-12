Template.chatScrollView.items = ->
  query = Chat.find {},{sort: {createdAt: 1}}
