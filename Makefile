
REG="kaija"
NAME="owasp-dep-track"
TAG="latest"

.PHONY: build


all: build
build:
	docker build -t ${REG}/${NAME}:${TAG} .

run:
	docker run -d -p 8080:8080 --name ${NAME} ${REG}/${NAME}:${TAG}

stop:
	docker stop ${NAME}

push:
	docker push ${REG}/${NAME}:${TAG}
