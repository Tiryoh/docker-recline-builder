#!/bin/bash -eu

docker build -t recline-builder .
docker run --rm -v $(pwd):/output recline-builder
