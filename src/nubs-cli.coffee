Q      = require 'q'
colors = require 'colors'
sockjs = require 'sockjs-stream'
http   = require 'http'


process.stdin.pause()

process.stdin.on 'data', (d) ->
  process.stdout.write(d)

webUri    = process.argv[2]
socketUri = webUri.replace('/o/', '/socket/o/').replace(/^http\:\/\//, '')

setup = (uri) ->
  # hit uri to setup socket listener
  request = Q.defer()

  http.get webUri, (d) ->
    request.resolve(d)
  .on 'error', (e) -> request.reject(e)

  request.promise

setup(webUri)
  .fail (error) ->
    console.error "#{error.toString()} #{webUri}\n".red
    process.exit(1)
  .done ->
    sock = sockjs(socketUri)

    sock.on 'end', (msg) ->
      process.exit()

    sock.on 'error', (e) ->
      console.error e.toString()

    sock.on 'connect', ->
      process.stdin.resume()
      process.stdin.pipe(sock)



