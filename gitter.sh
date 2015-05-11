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
		test -n "$ACCESS_KEY" -a -n "$SECRET_KEY" || { echo "ERROR: Please set ACCESS_KEY and SECRET_KEY environment variables"; exit 99; }
		s3cmd --config=s3cfg.conf --no-mime-magic --access_key="$ACCESS_KEY" --secret_key="$SECRET_KEY" --disable-multipart put responses/$RESPONDENT.tar.gz s3://$BUCKET
	fi
done