{ Meteor } = require "meteor/meteor"
require "/imports/api/collections.coffee"

if Meteor.isClient
  require "/imports/ui/router/router.coffee"
  Meteor.startup ->
    console.log "Moin!"

if Meteor.isServer
  Meteor.startup ->
    console.log "Yeah, Startup!"
