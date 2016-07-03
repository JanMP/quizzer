require "./gameList.jade"
{ Games } = require "/imports/api/collections.coffee"

Template.gameList.viewmodel
  games : -> Games.find()

Template.gameListItem.viewmodel
  selectGame : -> FlowRouter.go "/play/#{@_id()}"
