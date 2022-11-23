#/bin/bash -e

# fetch package updates from git
# usage: ./update.bash

if [[ $# -ne 0 ]]; then
  echo >&2 "usage: $(basename "$0")"
  exit 1
fi

for package in $(ls); do
  [[ ! -d $package ]] && continue

  echo "checking: $package"
  cd "$package"
  git clean -fqdx
  git checkout .
  git fetch
  git pull
  cd ../

  # don't overwhelm the aur
  sleep 0.5
done

exit 0
