#!/bin/bash
cd /build || exit 1
cp -r "$GITHUB_WORKSPACE"/* /build
cp -r "$GITHUB_WORKSPACE"/.* /build

RUSTC_VERSION=nightly-2020-07-20 PACKAGE=$INPUT_RUNTIME build --json | tee srtool_output.json

# copy the target dir back to preserve it
cp -r /build/target "$GITHUB_WORKSPACE"

du -hs "$GITHUB_WORKSPACE"

# Set a Github Action output for each key
while IFS= read -r line; do
  echo "::set-output name=$line::$(jq -r ".$line" < srtool_output.json)"
done <<< "$(jq -r 'keys[]' < srtool_output.json)"

# Copy the runtime from /builds to GITHUB_WORKSPACE to get around this weird artifact bug
cp "$(jq -r '.wasm' < srtool_output.json)" "$GITHUB_WORKSPACE"
path="$(jq -r '.wasm' < srtool_output.json | sed "s_^\._${GITHUB_WORKSPACE}_")"
echo "::set-output name=wasm::$path"
