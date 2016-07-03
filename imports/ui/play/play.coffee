require "./play.jade"

shuffle = require "lodash/shuffle"
{ Games, Cards } = require "/imports/api/collections.coffee"
{ getCardArray } = require "/imports/api/methods.coffee"
isEqual = require "lodash/isEqual"

Template.play.viewmodel
  gameId : ""
  gameName : -> Games.findOne(_id : @gameId())?.name
  cardIds : []
  loading : -> not @templateInstance.subscriptionsReady()
  threeCards : ->
    Cards.find
      _id :
        $in : (id for id in @threeCardIds())
  oneCard : -> Cards.findOne _id : @oneCardId()
  threeCardIds : []
  oneCardId : ""
  pickCards : ->
    @threeCardIds (shuffle @cardIds())[0..2]
    @oneCardId (shuffle @threeCardIds())[0]
  rightCount : 0
  wrongCount : 0
  percent : -> Math.round(@rightCount()/(@rightCount() + @wrongCount()) * 100)
  streak : 0
  result : ""
  showResult : false
  selectAnswer : (id) ->
    if id is @oneCard()._id
      @rightCount @rightCount() + 1
      @streak @streak() + 1
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
