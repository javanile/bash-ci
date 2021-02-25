#!/usr/bin/env bash
set -e

echo ">>> Testing..."

git clone git@gitlab.com:javanile/fixtures/private-repository.git

cd private-repository

date > TEST

echo -e "test:\n\tls" > Makefile

make test

git add .
git commit -am "TEST"
git push

cd ..

rm -fr private-repository
