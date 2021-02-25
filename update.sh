#!/usr/bin/env bash

versions=(
  5.1.4
)

for version in "${versions[@]}"; do
  mkdir -p ${version}
  sed -e 's!%{version}!'"${version}"'!' Dockerfile.template > ${version}/Dockerfile
  cp config ${version}/config
  cp bash-ci-entrypoint.sh ${version}/bash-ci-entrypoint.sh
  chmod +x ${version}/bash-ci-entrypoint.sh
  chmod 600 ${version}/config
  docker build -t javanile/bash-ci:${version} ${version}
  docker push javanile/bash-ci:${version}
done

git add .
git commit -am "new release"
git push
