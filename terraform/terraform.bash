#!/bin/bash

# simple wrapper around terraform to encrypt/decrypt the statefile
# usage: ./terraform.bash

if [[ $# -ne 0 ]]; then
  echo >&2 "usage: $(basename "$0")"
  exit 1
fi

if [[ -f terraform.tfstate.asc ]]; then

  if ! gpg -d terraform.tfstate.asc > terraform.tfstate; then
    echo >&2 "error: unable to decrypt statefile"
    exit 1
  fi
fi

terraform apply
tfret=$?

# we always want to re-encrypt the statefile; terraform doesn't do rollbacks
# so the state may have changed even though the apply failed
if ! gpg -ear 36FDA306 terraform.tfstate; then
  echo "error: statefile encryption failed!"
  exit 25
fi

exit $tfret
