test    = require './helpers'
expect  = test.expect
execute = test.execute


describe 'cli', ->
  it 'should print a message if used without a URL', (done) ->
    proc = execute()
    proc.stdout.on 'data', (d) ->
      expect(d.toString()).to.equal 'USAGE:  nubs [url] - obtain url at http://nubs.narf.io/\n'
      done()

    proc.stdout.resume()





