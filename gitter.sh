#!/bin/bash

INPUT=respondents.csv

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

(tail -n +2 $INPUT ; echo )| while IFS=, read RESPONDENT REPOSITORY
do
	echo "Fetching $REPOSITORY"
	REPO="$(basename $REPOSITORY)"

	REPONAME="${REPO%.git}"

	git clone $REPOSITORY && tar -czf responses/$RESPONDENT.tar.gz $REPONAME && rm -rf $REPONAME

done
