#!/bin/bash

logger::error() {
    # `date --iso-8601=ns`
    printf "%s\t%s\t%s\n" "$(date +'%Y-%m-%dT%H:%M:%S%z')" "[ERROR]" "$@" >&2
}

logger::info() {
    # `date --iso-8601=ns`
    printf "%s\t%s\t%s\n" "$(date +'%Y-%m-%dT%H:%M:%S%z')" "[INFO]" "$@" >&2
}

PACKAGES=("arch" "benchmarks" "blog" "build" "crypto" "debug" "exp" "image" "lint" "mobile" "net" "oauth2" "perf" "playground" "review" "sync" "sys" "talks" "text" "time" "tools" "tour" "vgo" "website" "xerrors")
readonly PACKAGES

for package in ${PACKAGES[@]}; do
    if [[ -d "$GOPATH/src/golang.org/x/$package/.git" ]]; then
        logger::info "$GOPATH/src/golang.org/x/$package is exist."
        git pull --quiet
    else
        rm -rf "$GOPATH/src/golang.org/x/$package/"
        git clone git@github.com:golang/$package.git $GOPATH/src/golang.org/x/$package
    fi
done
