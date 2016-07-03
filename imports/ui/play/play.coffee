require "./play.jade"

shuffle = require "lodash/shuffle"
{ Games, Cards, Players } = require "/imports/api/collections.coffee"
{ getCardArray, savePlayerScores, saveCardScores } = require "/imports/api/methods.coffee"
isEqual = require "lodash/isEqual"

Template.play.viewmodel
  gameId : ""
  gameName : -> Games.findOne(_id : @gameId())?.name
  loading : -> not @templateInstance.subscriptionsReady()

  #selecting random cards:
  cardIds : [] #set in autorun when gameId changes
  threeCardIds : []
  oneCardId : ""
  pickCards : ->
    @threeCardIds (shuffle @cardIds())[0..2]
    @oneCardId (shuffle @threeCardIds())[0]
  threeCards : ->
    Cards.find
      _id :
        $in : (id for id in @threeCardIds())
  oneCard : -> Cards.findOne _id : @oneCardId()

  #display player statistics
  player : ->
    if Meteor.userId()
      Players.findOne userId : Meteor.userId()
  rightCount : 0
  rightCountOutput : -> @player()?.rightCount or @rightCount()
  wrongCount : 0
  wrongCountOutput : -> @player()?.wrongCount or @wrongCount()
  percent : ->
    Math.round(@rightCountOutput()/(@rightCountOutput() +
    @wrongCountOutput()) * 100)
  streak : 0
  streakOutput : -> @player()?.streak or @streak()
  longestStreak : 0
  longestStreakOutput : -> @player()?.longestStreak or @longestStreak()

  #handle answer selection
  result : ""
  showResult : false
  selectAnswer : (id) ->
    answerCorrect = id is @oneCard()._id
    if Meteor.userId()
      savePlayerScores.call answerCorrect : answerCorrect
    saveCardScores.call
      answerCorrect : answerCorrect
      cardId : @oneCardId()
    if answerCorrect
      @rightCount @rightCount() + 1
      @streak @streak() + 1
      if @streak() > @longestStreak()
        @longestStreak @streak()
      @result "'#{@oneCard().name}' is the right answer."
    else
      @wrongCount @wrongCount() + 1
      @streak 0
      @result "Wrong! The right Answer is: #{@oneCard().name}!!"
    @showResult true
    Meteor.setTimeout =>
      @showResult false
      @pickCards()
    , 2500

  autorun : [
    ->
      @templateInstance.subscribe "quizzer.cards", gameId : @gameId()
    ->
      newGameId = FlowRouter.getParam "id"
      oldGameId = @gameId()
      @gameId newGameId
      unless oldGameId is newGameId and @cardIds()?
        getCardArray.call gameId : @gameId(), (err, res) =>
          unless err
            @cardIds res
            @pickCards()
  ]

Template.flavorText.viewmodel
  percent : -> Math.floor(@rightCount() / @totalCount() * 100) or 0
  totalCount : -> @rightCount() + @wrongCount()
