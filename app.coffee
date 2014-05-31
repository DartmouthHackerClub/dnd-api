express = require 'express'
mongo = require 'mongodb'

app = express()

app.configure ->
  app.set 'port', process.env.PORT or 4000
  app.use express.bodyParser()
  app.set 'mongoUri', process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or 'mongodb://localhost/dnd-api'
  app.set 'resultLimit', process.env.RESULT_LIMIT or 1500
# app.set 'apikey', process.env.DND_API_KEY or 'testkey'

app.configure 'development', ->
  app.use express.logger('dev')
  app.use express.errorHandler()

app.configure 'production', ->
  app.enable 'trust proxy'

#checkApiKey = (req, res, next) ->
#  if req.param('apikey') != app.get('apikey')
#    res.status(401).send("bad API key")
#  else
#    next()
#app.all('*', checkApiKey)

regexQuery = (query) ->
  params = {}
  for key, value of query
    if key not in ['uid', 'name', 'surname', 'firstname', 'nickname', 'email', 'website', 'phone', 'hinman', 'department']
      continue
    words = value.split ' '
    if words.length > 1
      regex = ".*(#{words.join '|'}).*"
    else
      regex = words[0]
    params[key] =
      $regex: regex
      $options: 'i'
  params

lookup = (params, callback) ->
  mongo.Db.connect app.get('mongoUri'), (err, db) ->
    db.collection 'people', (err, collection) ->
      collection.find(params).limit(app.get 'resultLimit').toArray (err, docs) ->
        callback docs

search = (query, filter, callback) ->
  mongo.Db.connect app.get('mongoUri'), (err, db) ->
    command = {text: 'people', search: query}
    if filter
      command['filter'] = filter
    db.command command, (err, res) ->
      if res? and res.results?
        callback (item.obj for item in res.results)
      else
        console.error "#{query}: query failed: please enable mongodb full text search"
        callback []

app.get '/', (req, res) ->
  lookup regexQuery(req.query), (json) ->
    res.jsonp json

app.post '/', (req, res) ->
  lookup req.body, (json) ->
    res.jsonp json

app.get '/:query', (req, res) ->
  search req.params.query, regexQuery(req.query), (json) ->
    res.jsonp json

app.listen app.get('port'), ->
  console.log "Server started on port #{app.get 'port'} in #{app.settings.env} mode."
