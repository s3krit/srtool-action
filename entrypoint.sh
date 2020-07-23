#!/bin/bash
# Not actually sure if it just gets made...
cd /build || exit 1
mv "$GITHUB_WORKSPACE"/* .
mv "$GITHUB_WORKSPACE"/.* .
RUSTC_VERSION=nightly-2020-07-20 PACKAGE=$INPUT_RUNTIME build --json | tee srtool_output.json
# Set a Github Action output for each key
while IFS= read -r line; do
  echo "::set-output name=$line::$(jq -r ".$line" < srtool_output.json)"
done <<< "$(jq -r 'keys[]' < srtool_output.json)"
