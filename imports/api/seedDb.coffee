cards = require "./cards.json"
{ Games, Cards } = require "./collections.coffee"

exports.seedDb = ->
  selector = name : "Hearthstone"
  unless Games.findOne selector
    console.log "seeding the db"
    gameId = Games.insert selector
    Cards.remove {}
    for card in cards when card.flavor?
      Cards.insert
        name : card.name
        flavor : card.flavor
        gameId : gameId
        rightCount : 0
        wrongCount : 0
