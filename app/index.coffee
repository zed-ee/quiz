require('lib/setup')

Spine   = require('spine')
{Stage} = require('spine.mobile')
{Panel}          = require('spine.mobile')
#Startup = require('controllers/startup')
Index = require('controllers/index')
Intro = require('controllers/intro')
Quiz = require('controllers/quiz')
Answer = require('controllers/answer')
Results = require('controllers/results')

class App extends Stage.Global
  events:
    'click .set_lang': 'set_lang'   
    'tap .restart': 'restart'   
  
  set_lang: (e) =>
    lang = if window.lang == 'en' then 'et' else 'en'
    top.location.href= top.location.pathname + "?" + lang
    
  restart: (e) =>
    #@navigate('/', trans: 'right')
    window.location.reload()
    
  constructor: (params)->
    @log params
    lang = location.search || "?et"
    window.lang = lang.substr(1)
    $("body").addClass(window.lang)
    super

    @index = new Index
    @intro = new Intro
    @quiz = new Quiz
    @answer = new Answer
    @results = new Results

    @routes
      '/':        (params) -> @index.active(params)
      '/en':        (params) -> @index.active(params)
      '/et':        (params) -> @index.active(params)
      '/intro/:test': (params) -> @intro.active(params)
      '/quiz/:test/:page': (params) -> @quiz.active(params)
      '/answer/:test/:page': (params) -> @answer.active(params)
      '/results/:test': (params) -> @results.active(params)

    Spine.Route.setup()
    #Spine.Route.setup(shim: true)
    if params.skip_index
      @intro.active( test:'quiz' )
    else
      @index.active()
    #@navigate('/intro', trans: 'right')
       
module.exports = App