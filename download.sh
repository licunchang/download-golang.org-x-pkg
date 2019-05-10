#!/bin/bash

log::error() {
    # `date --iso-8601=ns`
    printf "%s\t%s\t%s\n" "$(date +'%Y-%m-%dT%H:%M:%S%z')" "[ERROR]" "$@" >&2
}

log::info() {
    # `date --iso-8601=ns`
    printf "%s\t%s\t%s\n" "$(date +'%Y-%m-%dT%H:%M:%S%z')" "[INFO]" "$@" >&2
}

PACKAGES=("arch" "benchmarks" "blog" "build" "crypto" "debug" "exp" "image" "lint" "mobile" "net" "oauth2" "perf" "playground" "review" "sync" "sys" "talks" "text" "time" "tools" "tour" "vgo" "website" "xerrors")
readonly PACKAGES

PACKAGES_NEED_UPDATE=()

for package in ${PACKAGES[@]}; do
    if [[ -d "$GOPATH/src/golang.org/x/$package/.git" ]]; then
        PACKAGES_NEED_UPDATE+=($package)
    else
        log::info "Github project url: https://github.com/golang/$package"

        rm -rf "$GOPATH/src/golang.org/x/$package/"
        log::info "    git clone git@github.com:golang/$package.git $GOPATH/src/golang.org/x/$package"
        git clone --quiet git@github.com:golang/$package.git $GOPATH/src/golang.org/x/$package > /dev/null 2>&1
        if [[ "$?" -ne 0 ]]; then
            log::error "    https://github.com/golang/$package clone error"
        fi
    fi
done

for package in ${PACKAGES_NEED_UPDATE[@]}; do
    log::info "Github project url: https://github.com/golang/$package"

    log::info "    git -C $GOPATH/src/golang.org/x/$package pull"
    git -C $GOPATH/src/golang.org/x/$package pull --quiet > /dev/null 2>&1
    if [[ "$?" -ne 0 ]]; then
        log::error "    https://github.com/golang/$package pull error"
    fi
done