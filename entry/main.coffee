{ Meteor } = require "meteor/meteor"
require "/imports/api/methods.coffee"

if Meteor.isClient
  require "/imports/ui/router/router.coffee"

  { Accounts } = require "meteor/accounts-base"
  Accounts.ui.config
    passwordSignupFields : "USERNAME_ONLY"

  Meteor.subscribe "quizzer.games"
  Meteor.subscribe "quizzer.players"


if Meteor.isServer
  require "/imports/api/collections.coffee"
  require "/imports/api/publications.coffee"

  { seedDb } = require "/imports/api/seedDb.coffee"
  Meteor.startup ->
    seedDb()
