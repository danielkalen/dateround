# Based on https://github.com/twilson63/cakefile-template

fs            = require 'fs'
{print}       = require 'sys'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold = '\033[0;1m'
green = '\033[0;32m'
reset = '\033[0m'
red = '\033[0;31m'

guessPath = (exec, module) ->
  module ||= exec
  path = "#{__dirname}/node_modules/#{module}/bin/#{exec}"
  try
    fs.statSync path
    path
  catch error
    exec

coffeePath  = guessPath 'coffee', 'coffee-script'
jasminePath = guessPath 'jasmine-node'
doccoPath   = guessPath 'docco'

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c', '-o', 'lib', 'src']
  options.unshift '-w' if watch

  coffee = spawn coffeePath, options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> log data.toString(), red
  coffee.on 'exit', (status) -> callback?() if status is 0

spec = (callback) ->
  options = ['spec', '--coffee', '--verbose']
  spec = spawn jasminePath, options
  spec.stdout.on 'data', (data) -> print data.toString()
  spec.stderr.on 'data', (data) -> log data.toString(), red
  spec.on 'exit', (status) -> callback?() if status is 0

task 'docs', 'Generate annotated source code with Docco (requires pygmentize)', ->
  fs.readdir 'src', (err, contents) ->
    files = ("src/#{file}" for file in contents when /\.coffee$/.test file)
    docco = spawn doccoPath, files
    docco.stdout.on 'data', (data) -> print data.toString()
    docco.stderr.on 'data', (data) -> log data.toString(), red
    # docco.on 'exit', (status) -> callback?() if status is 0

task 'build', 'Compile CoffeeScript to JavaScript', ->
  build()

task 'spec', 'Run Specs with Jasmine-Node', ->
  build -> spec()
