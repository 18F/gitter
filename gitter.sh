#!/bin/bash

URL=$1
REPO="$(basename $1)"
REPONAME="${REPO%.git}"
RESPONDENT=$2

git clone $1 && tar -czf responses/$RESPONDENT.tar.gz $REPONAME && rm -rf $REPONAME