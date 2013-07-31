Q             = require 'q'
chai          = require 'chai'
expect        = require('chai').expect
sockjs        = require 'sockjs-stream'
path          = require 'path'
{spawn, exec} = require 'child_process'

testExecutable = path.resolve('./test/nubs.test')

execute = (args) ->
  proc = spawn(testExecutable)
  proc.stdout.pause()
  proc.stdin.pause()
  proc



module.exports =
  expect:   expect
  sockjs:   sockjs
  execute:  execute
