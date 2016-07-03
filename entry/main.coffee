{ Meteor } = require "meteor/meteor"
require "/imports/api/methods.coffee"

if Meteor.isClient
  require "/imports/ui/router/router.coffee"
  Meteor.subscribe "quizzer.games"

if Meteor.isServer
  require "/imports/api/collections.coffee"
  require "/imports/api/publications"

  { seedDb } = require "/imports/api/seedDb.coffee"
  Meteor.startup ->
    seedDb()
