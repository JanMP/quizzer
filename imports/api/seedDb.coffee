cards = require "./cards.json"
{ Games, Cards } = require "./collections.coffee"

exports.seedDb = ->
  unless Games.findOne()
    gameId = Games.insert name : "Hearthstone"
    Cards.remove()
    for card in cards when card.flavor?
      Cards.insert
        name : card.name
        flavor : card.flavor
        gameId : gameId
