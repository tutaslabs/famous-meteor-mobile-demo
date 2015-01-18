
Router.route '/', ->
  App.ebtn = false
  this.render 'appMainView'
  Session.set 'currentHeadFootContentTemplate','page1ScrollView'


Router.route '/lessonone', ->
  this.render 'lessonOne'

Router.route '/lessontwo', ->
  this.render 'lessonTwo'

Router.route '/lessonthree', ->
  this.render 'lessonThree'
