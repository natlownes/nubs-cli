# nubs-cli

command line client for nubs; a program to pipe stuff to urls for viewing by you
and/or other parties.  like a github gist or pastie that updates in realtime but
doesn't get saved

# installing

`npm install nubs-cli && npm link nubs-cli` or `npm install -g nubs-cli`

### using

`tail -f /var/log/syslog | nubs http://nubs.narf.io/o/example`

then go to:  [http://nubs.narf.io/o/example](http://nubs.narf.io/o/example) to
view the output of your syslog

### todo
* detect when server goes down and attempt reconnects
* tests, whoops
* optparse for help flag....whoops


