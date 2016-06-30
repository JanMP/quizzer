{ Mongo } = require "meteor/mongo"

Quizzes = new Mongo.Collection "quizzes"
Quizzes.schema = new SimpleSchema
  title :
    type : String
Quizzes.attachSchema Quizzes.schema
exports.Quizzes = Quizzes

Questions = new Mongo.Collection "questions"
Questions.schema = new SimpleSchema
  text :
    type : String
  quizId :
    type : String
Questions.attachSchema Questions.schema
exports.Questions = Questions

Answers = new Mongo.Collection "answers"
Answers.schema = new SimpleSchema
  text :
    type : String
  questionId :
    type : String
  correct :
    type : Boolean
    optional : true
Answers.attachSchema Answers.schema
exports.Answers = Answers
