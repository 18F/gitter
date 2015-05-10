#!/bin/bash

INPUT=${1-respondents.csv} # Get csv from command line or default to respondents.csv 
BUCKET=${2-test} #Get S3 bucket name from command line or default to test

[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

(tail -n +2 $INPUT ; echo )| while IFS=, read RESPONDENT REPOSITORY
do
	echo "Fetching $REPOSITORY"
	REPO="$(basename $REPOSITORY)"

	REPONAME="${REPO%.git}"

	git clone $REPOSITORY && tar -czf responses/$RESPONDENT.tar.gz $REPONAME && rm -rf $REPONAME
	if [ $CONFIG ]; then
		s3cmd "$CONFIG" --no-mime-magic --disable-multipart put responses/$RESPONDENT.tar.gz s3://$BUCKET
	else
		s3cmd --no-mime-magic --disable-multipart put responses/$RESPONDENT.tar.gz s3://$BUCKET
	fi	
done