#!/bin/bash
tag=$(date +%s%N | sha256sum | head -c 8)
label="distrokid/teg-demo:${tag}"
echo "Building ${label}"
docker build -t ${label} .
docker tag ${label} distrokid/teg-demo:latest
