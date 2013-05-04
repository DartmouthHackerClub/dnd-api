express = require 'express'
mongo = require 'mongodb'

app = express()

app.configure ->
  app.set 'port', process.env.PORT or 4000
  app.use express.bodyParser()
  app.set 'mongoUri', process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or 'mongodb://localhost/dnd-api'

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler()

app.configure 'production', ->
  app.enable 'trust proxy'

mongo.Db.connect app.get('mongoUri'), (err, db) ->
  people = db.collection 'people'

  lookup = (params, callback) ->
    people.find(params).toArray (err, docs) ->
      callback docs

  search = (query, callback) ->
    db.command {text: 'people', search: query}, (err, res) ->
      callback (item.obj for item in res.results)

  app.get '/', (req, res) ->
    lookup req.query, (json) ->
      res.jsonp json

  app.post '/', (req, res) ->
    lookup req.body, (json) ->
      res.jsonp json

  app.get '/:query', (req, res) ->
    search req.params.query, (json) ->
      res.jsonp json

app.listen app.get('port'), ->
  console.log "Server started on port #{app.get 'port'} in #{app.settings.env} mode."
