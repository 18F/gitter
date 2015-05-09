#!/bin/bash

URL=$1
REPO="$(basename $1)"
REPONAME="${REPO%.git}"
RESPONDENT=$2

git clone $1 && tar -cf responses/$RESPONDENT.tar.gz $REPONAME && rm -rf $REPONAME