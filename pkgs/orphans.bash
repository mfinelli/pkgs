#!/bin/bash -e

# check for orphaned packages
# based on: https://gist.github.com/mfinelli/8dcbaf3e6fb1e7cee9990aee7be631c9
# usage: ./orphans.bash

if [[ $# -ne 0 ]]; then
  echo >&2 "usage: $(basename "$0")"
  exit 1
fi

AURBASE="https://aur.archlinux.org/rpc/?v=5&type=info"

if ! command -v jq > /dev/null 2>&1; then
  echo >&2 "error: jq not found!"
  exit 1
fi

queryurl="$AURBASE"
for package in $(ls); do
  [[ $package == README.md ]] && continue
  [[ $package == orphans.bash ]] && continue
  queryurl="${queryurl}&arg[]=${package}"
done

curl -s "$queryurl" | jq -r '.results[] | select(.Maintainer == null) | .Name'

exit 0
