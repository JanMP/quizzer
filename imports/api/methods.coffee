{ Game, Cards } = require "./collections.coffee"

exports.getCardArray = new ValidatedMethod
  name : "quizzer.getCardArray"
  validate :
    Cards.schema
      .pick ["gameId"]
      .validator()
  applyOptions :
    returnStubValue : false
  run : (gameIdSelector) ->
    Cards
      .find gameIdSelector
      .fetch().map (card) -> card._id
