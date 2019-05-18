#!/usr/bin/env bash

echo ">> installing correct rust version"
RUST_VERSION="nightly-2019-05-15"
rustup install "$RUST_VERSION"

echo ">> creating rust nightly docker image"
docker build --file Dockerfile.nightly --tag bench_rust_nightly .

for i in `seq 1 1`
do
    echo ">> iteration $i"

    echo ">> native"
    \time --format "user %U s | sys %S s | mem %K kb" -- cargo "+$RUST_VERSION" build --all --release

    echo ">> docker"
    \time --format "user %U s | sys %S s | mem %K kb" -- docker build .
done
