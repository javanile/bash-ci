
VERSION := 5.1.4

update:
	bash update.sh

build: update
	docker build -t javanile/bash-ci:$(VERSION) $(VERSION)

test: update
	docker run --rm \
		-e GITLAB_DEPLOY_KEY=deploy_key \
		-e GITLAB_USER_EMAIL=bianco@javanile.org \
		-v $${PWD}:/test -w /test javanile/bash-ci:$(VERSION) bash test.sh

release: build
	git add .
	git commit -am "New release" && true
	git push
	docker push javanile/bash-ci:$(VERSION)
