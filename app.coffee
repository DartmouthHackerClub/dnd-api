express = require 'express'
mongo = require 'mongodb'

app = express()

app.configure ->
  app.set 'port', 4000
  app.use express.bodyParser()

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler()
  app.set 'mongoUri', 'mongodb://localhost/dnd-api'

app.configure 'production', ->
  app.enable 'trust proxy'
  app.set 'mongoUri', process.env.MONGOLAB_URI or process.env.MONGOHQ_URL 

mongo.Db.connect app.get('mongoUri'), (err, db) ->
  app.all '/', (req, res) ->
    res.jsonp null

app.listen app.get('port'), ->
  console.log "Server started on port #{app.get 'port'} in #{app.settings.env} mode."
