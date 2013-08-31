# nubs-cli

[![Build
Status](https://travis-ci.org/natlownes/nubs-cli.png?branch=master)](https://travis-ci.org/natlownes/nubs-cli)

This is the command line client for [nubs](http://nubs.narf.io/) [(rhymes with
"tubs")](http://www.thefreedictionary.com/nub); a web app that
can receive and display output you pipe into it from the command line.  It's like
being able to pipe stdout to a URL, which you and whoever else can view updating
in realtime in the browser.  [Here's a blog post about it](http://blog.narf.io/2013/07/22/nubs.narf.io-pipe-output-from-the-command-line-to-a-url/).

# installing

`npm install nubs-cli && npm link nubs-cli` or `npm install -g nubs-cli`

### using

pipe stdout to a webpage

### example

`tail -f /var/log/syslog | nubs http://nubs.narf.io/o/example`

then go to:  [http://nubs.narf.io/o/example](http://nubs.narf.io/o/example) to
view the output of your syslog

### todo
* detect when server goes down and attempt reconnects


