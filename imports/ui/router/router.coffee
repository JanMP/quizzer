require "./layout.jade"
require "/imports/ui/navbar/navbar.jade"
require "/imports/ui/info/info.jade"
require "/imports/ui/quizList/quizList.coffee"

FlowRouter.route "/",
  name : "home"
  action : ->
    BlazeLayout.render "layout",
      main : "quizList"

FlowRouter.route "/info",
  name : "info"
  action : ->
    BlazeLayout.render "layout",
      main : "info"
