
Router.route '/', ->
  App.ebtn = false
  this.render 'appMainView'
  Session.set 'currentHeadFootContentTemplate','page1ScrollView'


