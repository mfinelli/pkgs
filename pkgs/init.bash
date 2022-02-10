#!/bin/bash -e

# after a fresh clone of the repository and `git submodule update --init` all
# of the submodules are in a detached head state. loop through them and check
# out the master branch so that our update.bash script works as expected.
# TODO: don't blindly assume `master`, and detect that the actual branch name
# is and use that

if [[ $# -ne 0 ]]; then
  echo >&2 "usage: $(basename "$0")"
  exit 1
fi

for package in $(ls); do
  [[ ! -d $package ]] && continue

  cd "$package"
  git checkout master
  git branch -u origin/master
  cd ../
done

exit 0
