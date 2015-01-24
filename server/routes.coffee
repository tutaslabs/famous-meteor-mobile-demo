
Router.route '/rest', ->
  this.response.statusCode = 401
  this.response.end 'ERROR'
,
  where: 'server'

Router.route '/rest/:article', ->

  t = this.params.article
  token = this.params.query.token

  if token?
    if token isnt 'iamgood'
      this.response.statusCode = 401
      this.response.end 'ERROR'
      return

  this.response.statusCode = 200
  this.response.setHeader "Content-Type", "application/json"
  this.response.setHeader "Access-Control-Allow-Origin", "*"
  this.response.setHeader "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
  if t is 'design'
    this.response.end JSON.stringify
      text: DesignText

  else
    this.response.statusCode = 401
    this.response.end 'ERROR'
,
  where: 'server'


DesignText = '<div class="task container">
<h1>Design and Technology</h1>


<p>Lorem ipsum ultricies risus sit tempor mattis turpis, scelerisque vitae aliquet egestas inceptos semper a, risus turpis molestie porta inceptos justo dictumst volutpat litora gravida eget sit diam morbi curabitur eleifend eget augue adipiscing a.</p>

<p>Sit fringilla facilisis himenaeos at vivamus gravida senectus fermentum ad pharetra, venenatis platea pharetra class nullam rutrum posuere egestas dapibus dui magna sapien duis nisi fames erat aenean nulla.</p>

<p>Augue placerat fringilla sodales rutrum ultricies bibendum curae, hac tincidunt vehicula scelerisque laoreet curae, dictumst convallis phasellus integer nam facilisis augue etiam pretium aenean eros aliquet cras lobortis tortor aliquet.</p>

<p>Cubilia feugiat imperdiet scelerisque sed eleifend per eleifend, quisque elementum leo at donec phasellus, nullam non ullamcorper class tortor tempus.</p>

<p>Tincidunt litora habitasse euismod iaculis sagittis rutrum nam est lacus, torquent pharetra mi sed et aliquam cras aenean, sed nec fringilla amet fermentum est mauris commodo.</p>

</div>'

