express = require 'express'

app = express()

app.configure ->
  app.set 'port'
  app.use express.bodyParser()

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler()

app.configure 'production', ->
  app.enable 'trust proxy'

app.all '/', (req, res) ->
  res.jsonp null

app.listen app.get('port'), ->
  console.log "Server started on port #{app.get 'port'} in #{app.settings.env} mode."
