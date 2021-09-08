#!/bin/bash -ex

# automate downloading latest db, repo-add, and then push it back
# usage: ./publish.bash ./package.tar.zst

if [[ $# -ne 1 ]]; then
  echo >&2 "usage: $(basename "$0") ./package.tat.zst"
  exit 1
fi

if [[ ! -f $1 ]]; then
  echo >&2 "error: unable to find package $1"
  exit 1
fi

SERVER=rome.mfpkg.net
FPATH=/srv/pkgs.finelli.dev/arch/x86_64

if ssh ${SERVER} "stat $FPATH/supermario.db" > /dev/null 2>&1; then
  rsync -lrvtP "${SERVER}:${FPATH}/supermario.db*" \
    "${SERVER}:${FPATH}/supermario.files*" .
  VERIFY=--verify
else
  # bootstrap a new db!
  VERIFY=""
fi

gpg -b "$1"

repo-add ${VERIFY} --sign supermario.db.tar.gz "$1"

rsync -lrvtP supermario.db* supermario.files* ./${1}{,.sig} ${SERVER}:${FPATH}

exit 0
