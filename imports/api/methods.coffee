{ Game, Cards, Players } = require "./collections.coffee"

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

exports.savePlayerScores = new ValidatedMethod
  name : "quizzer.savePlayerScores"
  validate :
    new SimpleSchema
      answerCorrect :
        type : Boolean
    .validator()
  run : ({answerCorrect}) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    Players.upsert userId : @userId,
      $setOnInsert :
        userId : @userId,
        name : Meteor.user().username
        rightCount : 0
        wrongCount : 0
        streak : 0
        longestStreak : 0
      $inc :
        if answerCorrect
          rightCount : 1
          streak : 1
        else
          wrongCount : 1
      $set :
        unless answerCorrect
          streak : 0
    if Meteor.isServer
      Players.update userId : @userId,
        $max :
          longestStreak : Players.findOne(userId : @userId)?.streak

exports.saveCardScores = new ValidatedMethod
  name : "quizzer.saveCardScores"
  validate :
    new SimpleSchema
      answerCorrect :
        type : Boolean
      cardId :
        type : String
    .validator()
  run : ({ answerCorrect, cardId }) ->
    Cards.update _id : cardId,
      $inc :
        if answerCorrect
          rightCount : 1
        else
          wrongCount : 1
