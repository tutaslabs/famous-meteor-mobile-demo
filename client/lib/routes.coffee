
Router.route '/', ->
  this.render 'appMainView'
Router.route '/chat', ->
  this.render 'chatScrollView'
Router.route '/lessonone', ->
  this.render 'lessonOne'
Router.route '/lessontwo', ->
  this.render 'lessonTwo'

Router.route '/lessonthree', ->
  this.render 'lessonThree'

