# Based on https://github.com/twilson63/cakefile-template

fs      = require 'fs'
{exec}  = require 'child_process'

guessPath = (exec, module) ->
  module ||= exec
  path = "#{__dirname}/node_modules/.bin/#{exec}"
  try
    fs.statSync path
    path
  catch error
    exec

coffeePath   = guessPath 'coffee'
doccoPath    = guessPath 'docco'
uglifyjsPath = guessPath 'uglifyjs', 'uglify-js'

run = (cmd, rest...) ->
  if cmd
    if cmd.apply
      cmd()
    else
      exec cmd, (error, stdout, stderr) ->
        console.log stdout if stdout
        console.log stderr if stderr
        if error
          console.log "Error (#{error.code}) running: #{cmd}\n"
          process.exit error.code
        else
          run.apply @, rest

build = (callback) ->
  run "#{coffeePath} -c -o dist lib",
      "#{uglifyjsPath} -o dist/index.min.js dist/index.js",
      callback


docs = (callback) ->
  run "#{doccoPath} lib/index.coffee", callback

buildPages = (callback) ->
  run '[ -d pages ] || git clone -b gh-pages git@github.com:danielkalen/dateround.git pages',
      'cp dist/*.js docs/*.css pages',
      'cp docs/dateround.html pages/index.html',
      'cd pages && git add . && git add -u && git commit -m "update pages" && git push'
      callback

task 'docs', 'Generate annotated source code with Docco (requires pygmentize)', ->
  docs()

task 'build', 'Compile CoffeeScript to JavaScript', ->
  build()

task 'pages', 'Build github pages', ->
  build -> docs -> buildPages()
