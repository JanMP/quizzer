require "./highScores.jade"
{ Players } = require "/imports/api/collections"

Template.highScores.viewmodel
  players : ->
    Players.find {},
      sort :
        longestStreak : -1

Template.highScoresItem.viewmodel
  color : ->
    ["yellow", "orange", "red"][@index()] or "grey"
