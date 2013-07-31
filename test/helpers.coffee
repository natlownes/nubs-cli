Q             = require 'q'
chai          = require 'chai'
expect        = require('chai').expect
sockjs        = require 'sockjs-stream'
path          = require 'path'
{spawn, exec} = require 'child_process'
express       = require 'express'
shoe          = require 'shoe'

testApp = (options) ->
  app    = options.app or express()
  listen = app.listen(options.port or 19144)
  sock = shoe (stream) ->
    stream.pipe(stream).pipe(stream)

  app.get '/otest/cli-test-disconnect-socket', (req, res) ->
    socketUri = "#{req.url}/socket"
    sock = shoe (stream) ->
      Q.delay(1000).done -> stream.end()

    sock.install(listen, socketUri)

    res.send(200)

  app.get '/otest/cli-test-write-from-socket', (req, res) ->
    socketUri = "#{req.url}/socket"
    sock = shoe (stream) ->
      things = do (int=0, stream) ->
        ->
          int++
          stream.write("the data, #{int}")

      intervalId = setInterval things, 1000

      Q.delay(2000).then -> clearInterval(intervalId)

    sock.install(listen, socketUri)

    res.send(200)

  app.get '/otest/no-socket', (req, res) ->
    # url works, socket not open
    res.send(200)

  app.get '/otest/:id', (req, res) ->
    # catchall
    socketUri = "#{req.url}/socket"
    sock.install(listen, socketUri)

    res.send(200)


  return app


testExecutable = path.resolve('./test/nubs.test')

execute = (args) ->
  proc = spawn(testExecutable, args or [])
  proc.stdout.pause()
  proc.stdin.pause()
  proc



module.exports =
  expect:   expect
  sockjs:   sockjs
  execute:  execute
  testApp:  testApp
