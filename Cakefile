# Based on https://github.com/twilson63/cakefile-template

fs      = require 'fs'
{print} = require 'sys'
{exec}  = require 'child_process'

guessPath = (exec, module) ->
  module ||= exec
  path = "#{__dirname}/node_modules/#{module}/bin/#{exec}"
  try
    fs.statSync path
    path
  catch error
    exec

coffeePath   = guessPath 'coffee', 'coffee-script'
jasminePath  = guessPath 'jasmine-node'
doccoPath    = guessPath 'docco'
uglifyjsPath = guessPath 'uglifyjs', 'uglify-js'

run = (cmd, rest...) ->
  if cmd
    if cmd.apply
      cmd()
    else
      exec cmd, (error, stdout, stderr) ->
        print stdout if stdout
        print stderr if stderr
        if error
          print "Error running: #{cmd}\n"
        else
          run.apply @, rest

build = (callback) ->
  run "#{coffeePath} -c -o lib src",
      "#{uglifyjsPath} -o lib/roundate.min.js lib/roundate.js",
      callback

spec = (callback) ->
  run "#{jasminePath} spec --coffee --verbose", callback

docs = (callback) ->
  run "#{doccoPath} src/roundate.coffee", callback

buildPages = (callback) ->
  run '[ -d pages ] || git clone -b gh-pages . pages',
      'touch pages/foo'
      'cp lib/*.js *.css pages',
      'cp docs/roundate.html pages/index.html',
      callback

task 'docs', 'Generate annotated source code with Docco (requires pygmentize)', ->
  docs()

task 'build', 'Compile CoffeeScript to JavaScript', ->
  build()

task 'spec', 'Run Specs with Jasmine-Node', ->
  spec()

task 'pages', 'Build github pages', ->
  build -> docs -> buildPages()
