#!/bin/bash -ex

# automate downloading the latest db, repo-remove, and then push it back
# usage: ./unpublish.bash package-name

if [[ $# -ne 1 ]]; then
  echo >&2 "usage: $(basename "$0") package-name"
  exit 1
fi

SERVER=rome.mfpkg.net
FPATH=/srv/pkgs.finelli.dev/arch/x86_64

if ! ssh ${SERVER} "stat $FPATH/supermario.db" > /dev/null 2>&1; then
  echo >&2 "error: database doesn't exist!"
  exit 1
fi

sdir="$(pwd)"
wdir="$(mktemp -d)"
cd "$wdir"

rsync -lrvtP "${SERVER}:${FPATH}/supermario.db*" \
  "${SERVER}:${FPATH}/supermario.files*" .

repo-remove --verify --sign supermario.db.tar.gz "$1"

rsync -lrvtP supermario.db* supermario.files* ${SERVER}:${FPATH}

cd "$sdir"
rm -rf "$wdir"

exit 0
