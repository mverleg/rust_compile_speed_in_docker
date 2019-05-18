#!/usr/bin/env bash

set -e

echo ">> installing correct rust version"
RUST_VERSION="nightly-2019-05-15"
rustup install "$RUST_VERSION"

echo ">> creating rust nightly docker image"
docker build --quiet --file Dockerfile.nightly --tag bench_rust_nightly .

REPS=5
for i in `seq 1 $REPS`
do
    echo ">> iteration $i of $REPS"

    # Native
    cargo clean --quiet --release
    \time --format "native: real %e s | user %U s | sys %S s | mem %K kb" -- cargo "+$RUST_VERSION" build --quiet --all --release
    cargo clean --quiet --release

    # Docker
    \time --format "docker: real %e s | user %U s | sys %S s | mem %K kb" -- docker build --no-cache --quiet --file Dockerfile.nocache .
done
