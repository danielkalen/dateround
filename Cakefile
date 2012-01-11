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
          print "Error (#{error.code}) running: #{cmd}\n"
          process.exit error.code
        else
          run.apply @, rest

build = (callback) ->
  run "#{coffeePath} -c -o lib src",
      "#{uglifyjsPath} -o lib/roundate.min.js lib/roundate.js",
      callback

spec = (callback) ->
  # manually handle this because jasmine-node does not return an error on test failure
  exec "#{jasminePath} spec --coffee --verbose", (error, stdout, stderr) ->
    print stdout
    m = stdout.match /\d+ tests, \d+ assertions, (\d+) failure/
    if !m || parseInt(m[1]) > 0
      process.exit(1)

docs = (callback) ->
  run "#{doccoPath} src/roundate.coffee", callback

buildPages = (callback) ->
  run '[ -d pages ] || git clone -b gh-pages git@github.com:patdeegan/roundate.git pages',
      'cp lib/*.js docs/*.css pages',
      'cp docs/roundate.html pages/index.html',
      'cd pages && git add . && git add -u && git commit -m "update pages" && git push'
      callback

task 'docs', 'Generate annotated source code with Docco (requires pygmentize)', ->
  docs()

task 'build', 'Compile CoffeeScript to JavaScript', ->
  build()

task 'spec', 'Run Specs with Jasmine-Node', ->
  spec()

task 'pages', 'Build github pages', ->
  build -> docs -> buildPages()
