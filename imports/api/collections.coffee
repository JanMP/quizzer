{ Mongo } = require "meteor/mongo"

Games = new Mongo.Collection "games"
Games.schema = new SimpleSchema
  name :
    type : String
Games.attachSchema Games.schema
exports.Games = Quizzes

Questions = new Mongo.Collection "cards"
Questions.schema = new SimpleSchema
  name :
    type : String
  flavorText :
    type : String
  gameId :
    type : String
Questions.attachSchema Questions.schema
exports.Questions = Questions
