Template.designScrollView.helpers

  content: ->
    sp =
      params:
        "token":'iamgood'

  # the information we are requesting - we will be getting back a JSON string
  # of the data (text of post/article whatever)
    url = Session.get('serverURL')+'/rest/design/'

  # perform the request to the server
    HTTP.call 'GET',url,sp,(error,result) =>
      if error
        t = 'Please check your internet connection'
      else
        t = JSON.parse(result.content).text
      Session.set 'design',t
    Session.get 'design'
