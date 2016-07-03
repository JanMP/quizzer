require "./layout.jade"
require "/imports/ui/navbar/navbar.jade"
require "/imports/ui/info/info.jade"
require "/imports/ui/gameList/gameList.coffee"
require "/imports/ui/play/play.coffee"
require "/imports/ui/highScores/highScores.coffee"

FlowRouter.route "/",
  name : "home"
  action : ->
    BlazeLayout.render "layout",
      main : "gameList"

FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "layout",
      main : "info"

FlowRouter.route "/play/:id",
  name : "play"
  action : ->
    BlazeLayout.render "layout",
      main : "play"

FlowRouter.route "/high-scores",
  name : "high-scores"
  action : ->
    BlazeLayout.render "layout",
      main : "highScores"
