require 'js-yaml'
mongo = require 'mongodb'
dnd = require('./dnd.yaml')

getField = (field) ->
  if not field?
    return null
  else if Array.isArray field
    return field[0]
  else
    return field

getData = (person) ->
  uid: getField person.uid
  name: getField person.cn
  surname: getField person.sn
  firstname: getField person.givenName
  nickname: getField person.nickname
  email: getField person.mail
  website: getField person.dndUrl
  phone: getField person.telephoneNumber
  hinman: getField person.dndHinmanaddr
  department: getField person.dndDeptclass
  affiliations: person.eduPersonAffiliation
  
mongoUri = process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or 'mongodb://localhost/dnd-api'
mongo.Db.connect mongoUri, (err, db) ->
  people = db.collection 'people'
  people.insert (getData(person) for id, person of dnd), (err, res) ->
    people.ensureIndex {"$**": "text"}, {name: "SearchIndex"}, (err, index) ->
      db.close()
