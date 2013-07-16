.PHONY: all serve clean

COFFEE:=./node_modules/.bin/coffee

#### General

all: build

build: src/*coffee
		@$(COFFEE) -v > /dev/null
			$(COFFEE) -o lib/ -c src/*.coffee

clean:
		rm -f lib/*.js

