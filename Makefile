
REG="kaija"
NAME="owasp-dep-track"
TAG="latest"

.PHONY: build


all: build
build:
	docker build -t ${REG}/${NAME}:${TAG} .

run:
	docker run -d ${REG}/${NAME}:${TAG}

push:
	docker push ${REG}/${NAME}:${TAG}
