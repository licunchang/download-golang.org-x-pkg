#!/bin/bash

PACKAGES=("arch" "benchmark" "blog" "build" "crypto" "debug" "exp" "image" "lint" "mobile" "net" "oauth2" "perf" "playground" "review" "sync" "sys" "talks" "text" "time" "tools" "tour" "vgo" "website" "xerrors")
readonly PACKAGES

for package in ${PACKAGES[@]}; do
    if [[ -d "$GOPATH/src/golang.org/x/$package/.git" ]]; then
        git pull
    else
        rm -rf "$GOPATH/src/golang.org/x/$package/"
        git clone git@github.com:golang/$package.git $GOPATH/src/golang.org/x/$package
    fi
done
