#!/bin/bash

INPUT=${1-respondents.csv} # Get csv from command line or default to respondents.csv 
BUCKET=${2-test}
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

(tail -n +2 $INPUT ; echo )| while IFS=, read RESPONDENT REPOSITORY
do
	echo "Fetching $REPOSITORY"
	REPO="$(basename $REPOSITORY)"

	REPONAME="${REPO%.git}"

	git clone $REPOSITORY && tar -czf responses/$RESPONDENT.tar.gz $REPONAME && rm -rf $REPONAME

	if [ $TEST ]; then
		s3cmd --config tests/s3.conf --disable-multipart put responses/$RESPONDENT.tar.gz s3://$BUCKET
	fi

done