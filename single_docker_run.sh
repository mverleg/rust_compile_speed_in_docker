#!/usr/bin/env bash

set -e

echo ">> creating rust nightly docker image"
docker build --quiet --file Dockerfile.nightly --tag bench_rust_nightly .

# Docker
\time --format "docker: real %e s | user %U s | sys %S s | mem %K kb" -- docker build --no-cache --quiet --file Dockerfile.nocache .


