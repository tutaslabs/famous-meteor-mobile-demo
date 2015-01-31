
Router.route '/', ->
  this.render 'appMainView'
Router.route '/chat', ->
  this.render 'chatScrollView'