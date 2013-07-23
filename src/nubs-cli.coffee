Q      = require 'q'
colors = require 'colors'
sockjs = require 'sockjs-stream'
url    = require 'url'
http   = require 'http'


process.stdin.pause()

process.stdin.on 'data', (d) ->
  process.stdout.write(d)

webUri    = process.argv[2]
if not webUri?
  console.log """
  USAGE:  nubs [url] - obtain url at http://nubs.narf.io/
  """
  process.exit(1)

toSocketUri = (str) ->
  #str.replace('/o/', '/socket/o/')
  "#{str}/socket"
    .replace(/^http\:\/\//, '')

socketUri = toSocketUri(webUri)

setup = (uri) ->
  # hit uri to setup socket listener
  parsedUri = url.parse(uri)

  def = Q.defer()
  options =
    hostname: parsedUri.hostname
    port:     parsedUri.port
    path:     parsedUri.path
    method:   'GET'
    agent:    false
    headers:
      'Accept': 'text/html'
      'Host':   parsedUri.hostname
      'User-Agent': 'nubs-cli'

  request = http.request options, (d) -> def.resolve(d)
  request.on 'error', (e) -> def.reject(e)
  request.end()

  def.promise

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



