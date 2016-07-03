{ Meteor } = require "meteor/meteor"
{ Games, Cards, Players } = require "/imports/api/collections.coffee"

Meteor.publish "quizzer.games", -> Games.find()
Meteor.publish "quizzer.players", -> Players.find()

Meteor.publish "quizzer.cards",
  (gameIdSelector) ->
    Cards.schema.pick(["gameId"]).validate gameIdSelector
    Cards.find gameIdSelector

Meteor.publish "quizzer.card",
  (cardIdSelector) ->
    new SimpleSchema
      _id :
        type : String
    .validate cardIdSelector
    Cards.find cardIdSelector
