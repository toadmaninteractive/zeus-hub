BRANCH = main
DESTDIR = server

DOCKER=docker
DOCKER_OPTS=
DOCKER_IMAGE=zeus
DOCKER_NAME=zeus
DOCKER_PORT=30000

all: compile generate

update: update-tree update-deps

clean:
	rm -rf build
	escript rebar clean

update-tree:
	git fetch
	git reset --hard origin/$(BRANCH)
	git submodule sync
	git submodule update --init --force --recursive

update-deps:
	escript rebar get-deps update-deps

compile:
	escript rebar compile

generate:
	escript rebar generate

install:
	cp -Rf build/* $(DESTDIR)/

docker-build:
	${DOCKER} ${DOCKER_OPTS} build -t ${DOCKER_IMAGE} .

docker-rm:
	${DOCKER} ${DOCKER_OPTS} rm -f ${DOCKER_NAME} || true

docker-run:
	${DOCKER} ${DOCKER_OPTS} run -dt \
		--name=${DOCKER_NAME} \
		-p=${DOCKER_PORT}:30000 \
		-v $PWD/.docker/db:/zeus/var/db \
		-v $PWD/.docker/log${DOCKER_NAME}/:/zeus/log \
		${DOCKER_IMAGE}
