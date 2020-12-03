BRANCH = v1.2.2

.PHONY: build
build:
	docker image build --build-arg BRANCH=$(BRANCH) -t weaming/lotus:$(BRANCH) -f lotus.dockerfile .

rebuild:
	docker image build --build-arg BRANCH=$(BRANCH) --no-cache -t weaming/lotus:$(BRANCH) -f lotus.dockerfile .

build-env:
	docker build -t weaming/lotus-build-env -f lotus-build-env.dockerfile .

build-runtime:
	docker build -t weaming/lotus-runtime -f lotus-runtime.dockerfile .

run:
	docker container run -p 1235:1235 -p 1234:1234 --detach --name lotus weaming/lotus:$(BRANCH) /bin/entrypoint -d

bash:
	docker exec -it lotus /bin/bash

sync-status:
	docker exec -it lotus lotus sync status

log:
	docker logs lotus -f

stop:
	docker stop lotus

rm:
	docker rm lotus
