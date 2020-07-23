#!/bin/sh
# Not actually sure if it just gets made...
cd /build || exit 1
mv "$GITHUB_WORKSPACE"/* .
RUSTC_VERSION=nightly-2020-07-20 PACKAGE=$INPUT_RUNTIME build
