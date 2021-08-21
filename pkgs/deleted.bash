#!/bin/bash -e

# checks for packages that are no longer on the AUR (maybe they were moved to
# [community])
# usage: ./deleted.bash

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
  [[ ! -d $package ]] && continue
  queryurl="${queryurl}&arg[]=${package}"
done

results="$(curl -s "$queryurl" | jq -r '.results[] | .Name')"

for package in $(ls); do
  [[ ! -d $package ]] && continue

  if ! grep -q "^${package}$" <<< "$results"; then
    echo "$package"
  fi
done

exit 0
