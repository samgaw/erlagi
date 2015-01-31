CWD=$(shell pwd)
NAME=$(shell basename ${CWD})

all: clean compile edoc release
	./rebar3 compile

edoc:
	./rebar doc

compile:
	./rebar3 compile

test: compile
	./rebar3 eunit skip_deps=true

release: test
	(cd rel && ../rebar generate && cd -)

node:
	(cd rel && ../rebar3 create-node nodeid=${NAME} && cd -)

clean:
	./rebar3 clean
	rm -rf rel/${NAME}

run:
	rel/${NAME}/bin/${NAME} start

runconsole:
	rel/${NAME}/bin/${NAME} console

alldev: clean all runconsole
