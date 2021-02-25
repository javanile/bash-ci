
VERSION := 5.1.4

update:
	bash update.sh

build: update
	docker build -t javanile/bash-ci:$(VERSION) $(VERSION)

test: update
	@if [ ! -f deploy_key ]; then ssh-keygen -t rsa -b 4096 -C git -f deploy_key -q -N ""; fi
	@docker run --rm \
		-e CI_PROJECT_DIR=/test \
		-e GITLAB_DEPLOY_KEY=deploy_key \
		-e GITLAB_USER_EMAIL=bianco@javanile.org \
		-v $${PWD}:/test -w /test javanile/bash-ci:$(VERSION) bash test.sh

release: build
	git add .
	git commit -am "New release" && true
	git push
	docker push javanile/bash-ci:$(VERSION)
