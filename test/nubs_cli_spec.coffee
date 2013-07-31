test    = require './helpers'
expect  = test.expect
execute = test.execute
colors = require 'colors'

app = test.testApp(port: 19144)

makeUri = (path) ->
  port = 19144
  path = path or (new Date()).getTime()
  "http://localhost:#{port}/otest/#{path}"

describe 'cli', ->
  context 'used with a url as the first argument', ->
    context 'with a listening socket', ->
      url = makeUri('cli-test-1')

      it 'should pipe stdin right on thru', (done) ->
        proc = execute [url]
        proc.stdin.write 'hello\n'

        proc.stdout.on 'data', (d) ->
          expect(d.toString()).to.equal 'hello\n'
          done()

        proc.stdin.resume()
        proc.stdout.resume()

    context 'when socket requests end', ->
      url = makeUri('cli-test-disconnect-socket')

      it 'should exit process with code 0', (done) ->
        proc = execute [url]
        proc.stdin.write 'hello\n'

        proc.on 'close', (code) ->
          expect(code).to.equal 0
          done()

        proc.stdin.resume()
        proc.stdout.resume()

    context 'without a listening socket', ->
      @timeout 4000
      url = "http://localhost:23233/otest/not-listening"

      it 'should give up within 4 seconds and return 1', (done) ->
        proc = execute [url]
        proc.stdin.write 'hello\n'

        proc.on 'close', (exitCode) ->
          expect(exitCode).to.equal 1
          done()

        proc.stdin.resume()
        proc.stdout.resume()

      it 'should print a connection refused message to STDERR', (done) ->
        proc = execute [url]
        proc.stderr.on 'data', (d) ->
          expect(d.toString())
            .to.equal "Error: connect ECONNREFUSED #{url}\n".red + "\n"
          done()

    context 'with a working http connection, but no listening socket', ->
      url = makeUri('no-socket')


  context 'used without url as the first argument', ->
    it 'should print a message', (done) ->
      proc = execute()
      proc.stdout.on 'data', (d) ->
        expect(d.toString())
          .to.equal 'USAGE:  nubs [url] - obtain url at http://nubs.narf.io/\n'
        done()

      proc.stdout.resume()

    it 'should exit with exit code 1', (done) ->
      proc = execute()
      proc.on 'close', (exitCode) ->
        expect(exitCode).to.equal 1
        done()

      proc.stdout.resume()





