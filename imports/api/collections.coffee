{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"

Games = new Mongo.Collection "games"
Games.schema = new SimpleSchema
  name :
    type : String
Games.attachSchema Games.schema
exports.Games = Games

Cards = new Mongo.Collection "cards"
Cards.schema = new SimpleSchema
  name :
    type : String
  flavor :
    type : String
  gameId :
    type : String
Cards.attachSchema Cards.schema
exports.Cards = Cards
