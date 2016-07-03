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
  rightCount :
    type : Number
    min : 0
  wrongCount :
    type : Number
    min : 0
Cards.attachSchema Cards.schema
exports.Cards = Cards

Players = new Mongo.Collection "players"
Players.schema = new SimpleSchema
  userId :
    type : String
  name :
    type : String
  rightCount :
    type : Number
    min : 0
  wrongCount :
    type : Number
    min : 0
  streak :
    type : Number
    min : 0
  longestStreak :
    type : Number
    min : 0
Players.attachSchema Players.schema
exports.Players = Players
