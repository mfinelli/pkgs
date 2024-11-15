#!/bin/bash -ex

# automate downloading latest db, repo-add, and then push it back
# usage: ./publish.bash ./package.tar.zst

if [[ $# -ne 1 ]]; then
  echo >&2 "usage: $(basename "$0") ./package.tar.zst"
  exit 1
fi

if [[ ! -f $1 ]]; then
  echo >&2 "error: unable to find package $1"
  exit 1
fi

SERVER=rome.mfpkg.net
FPATH=/srv/pkgs.finelli.dev/arch/x86_64

if ssh -4 ${SERVER} "stat $FPATH/supermario.db" > /dev/null 2>&1; then
  rsync -4 -lrvtP "${SERVER}:${FPATH}/supermario.db*" \
    "${SERVER}:${FPATH}/supermario.files*" .
  VERIFY=--verify
else
  # bootstrap a new db!
  VERIFY=""
fi

gpg -u 36FDA306 -b "$1"

repo-add ${VERIFY} --key 36FDA306 --sign supermario.db.tar.gz "$1"

rsync -4 -lrvtP supermario.db* supermario.files* ./${1}{,.sig} ${SERVER}:${FPATH}

exit 0
