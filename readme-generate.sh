#!/bin/sh

docker run -v "$(pwd)/pipeline-operator:/helm-docs" jnorwood/helm-docs:latest
