#!/usr/bin/env bash
# Copyright (c) 2022-2024 José Manuel Barroso Galindo <theypsilon@gmail.com>

set -euo pipefail

git add dont_download2.sh
git commit -m "BOT: New dont_download2.sh" > /dev/null 2>&1 || true
git fetch origin master

set +e
CHANGES="$(git diff master:dont_download2.sh origin/master:dont_download2.sh | sed '/^[+-]export COMMIT/d' | sed '/^+++/d' | sed '/^---/d' | grep '^[+-]' | wc -l)"
set -e

if [ ${CHANGES} -ge 1 ] ; then
  echo "There are changes to push."
  echo
  git push origin master
  echo
  echo "New dont_download2.sh can be used."
  echo "NEW_RELEASE=yes" >> ${GITHUB_OUTPUT}
else
  echo "Nothing to be updated."
  echo "NEW_RELEASE=no" >> ${GITHUB_OUTPUT}
fi
